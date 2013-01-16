//
//  AsyncImageView.m
//
//  Created by Rafał Maślanka on 10-11-08.
//  Copyright (c) 2010 RAFIKEL Technologie. All rights reserved.
//

#import "AsyncImageView.h"

@implementation AsyncImageView
@synthesize delegate;
@synthesize status;
@synthesize errorType;
@synthesize imagePath;
@synthesize tempPath;

- (void)createTempPath {
	NSArray *parts = [imagePath componentsSeparatedByString:@"/"];
    NSString *name = [parts objectAtIndex:[parts count]-1];
	NSString *tempDir = NSTemporaryDirectory();
    self.tempPath = [NSString stringWithFormat:@"%@%@", tempDir, name];
}	

- (void)loadImageFromPath:(NSString *)path {
    imagePath = path;
    [self loadImage];
}

- (BOOL)loadImageFromTemp:(NSString *)path {
    
    imagePath = path;
    
    size = 0;
    received = 0;
    
	[self createTempPath];

    NSData *dat = [NSData dataWithContentsOfFile:self.tempPath];
    if ([dat length]>0) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:dat]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
        [self addSubview:imageView];
        imageView.frame = self.bounds;
        status = AsyncImageViewStatusOK;
		imageView = nil;
        if (self.delegate != NULL && [[self delegate] respondsToSelector:@selector(didFinishLoadingImage:withImage:)])
            [[self delegate] didFinishLoadingImage:YES withImage:[self image]];
		return YES;
    }
	return NO;
    
}

- (void)loadImage {
    
    // jednorazowy abort na żądanie
    if (self.status == AsyncImageViewStatusAborted) {
        status = AsyncImageViewStatusDefault;
        return;
    }
    
    // jeśli już odczytany, to abort
    if (self.status==AsyncImageViewStatusOK) return;
    
    // kasujemy wszystkie subviewy
    while ([[self subviews] count]>0) {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    status = AsyncImageViewStatusProcessing;
    spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerView.hidesWhenStopped = YES;
    [spinnerView startAnimating];
    [self addSubview:spinnerView];
	[self refreshWithFrame:self.frame];
    [spinnerView setNeedsLayout];
    [self setNeedsLayout];
    
    if (connection!=nil) {
		connection = nil;
    }
    if (data!=nil) {
		data = nil;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[imagePath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] 
                                                                               stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:30.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    if (!connection) {
        [self error];
		errorType = AsyncImageViewErrorTypeConnectionBad;
        NSLog(@"Brak połączenia lub nieprawidłowy link %@!", imagePath);
    }
    
}

- (void)reloadImage {
    
    NSLog(@"Reloading %@...", imagePath);
        
}

- (void)refreshWithFrame:(CGRect)frame {
	self.frame = frame;
	if (progressView!=nil) {
		progressView.frame = CGRectMake(
										self.frame.size.width * 0.9, 
										self.frame.size.height * 0.9,
										self.frame.size.width - (2*self.frame.size.width*0.9),
										10
										);
	}
	if (spinnerView!=nil) {
		spinnerView.frame = CGRectMake(
									   self.frame.size.width/2-10,
									   self.frame.size.height/2-10,
									   20,
									   20
									   );
	}
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
    [self error];
	errorType = AsyncImageViewErrorTypeConnectionLost;
	NSLog(@"Połaczenie przerwane!");
}

- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response {
	
	if (!connection) return;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *dic = [httpResponse allHeaderFields];
    
    if (![[dic objectForKey:@"Content-Type"] isEqualToString:@"image/jpeg"]) {
		NSLog(@"Nieprawidłowy typ pliku: %@!", [dic objectForKey:@"Content-Type"]);
		errorType = AsyncImageViewErrorTypeBadType;
        [self cancelLoadImage];
        return;
    }
    
    size = [[dic objectForKey:@"Content-Length"] intValue];
    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.progress = 0;
    [self addSubview:progressView];
	[self refreshWithFrame:self.frame];
    [progressView setNeedsLayout];
    [self setNeedsLayout];
    
}

//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {

	if (!connection) return;

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	if (data==nil) {
        data = [[NSMutableData alloc] initWithCapacity:2048]; 
    }
	[data appendData:incrementalData];
    received+= [incrementalData length];

    float percent = (float)received/(float)(size+0.00001);
	if (percent>0 && percent<1)
		progressView.progress = percent;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {

	if (!connection) return;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    status = AsyncImageViewStatusOK;
    if (progressView!=nil) [progressView removeFromSuperview];
    
	connection = nil;

	while ([[self subviews] count]>0) {
		[[[self subviews] objectAtIndex:0] removeFromSuperview];
	}
    
    if (size<1) {
        [self error];
		errorType = AsyncImageViewErrorTypeBadSize;
        NSLog(@"Uszkodzony obrazek!");
    }
    else {
		
        if (self.tempPath != nil) {
			[self createTempPath];
			[data writeToFile:self.tempPath atomically:YES];
			if (![self loadImageFromTemp:imagePath]) {
				[self error];
				errorType = AsyncImageViewErrorTypeOther;
				NSLog(@"Plik ma zerową wielkość!");
			}
		}
		else {
			imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
			imageView.contentMode = UIViewContentModeScaleAspectFit;
			imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
			[self addSubview:imageView];
			imageView.frame = self.bounds;
			[imageView setNeedsLayout];
			[self setNeedsLayout];
			imageView = nil;
			if (self.delegate != NULL && [[self delegate] respondsToSelector:@selector(didFinishLoadingImage:withImage:)])
				[[self delegate] didFinishLoadingImage:YES withImage:[self image]];
			data = nil;			
		}

    }

}

- (void)cancelLoadImage {

	[self error];
	
}

- (UIImage *)image {
	UIImageView *iv = [[self subviews] objectAtIndex:0];
	return [iv image];
}

- (void)error {
	
    [connection cancel];
	if (connection!=nil) {
		connection = nil;
    }
    if (data!=nil) {
		data = nil;
    }	
	
    status = AsyncImageViewStatusError;
    
    while ([[self subviews] count]>0) {
		[[[self subviews] objectAtIndex:0] removeFromSuperview];
	}
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"png"]]];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	imageView.frame = CGRectMake((self.frame.size.width-30)/2, (self.frame.size.height-30)/2, 30, 30);
	[self addSubview:imageView];
	imageView = nil;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	if (self.delegate != NULL && [[self delegate] respondsToSelector:@selector(didFinishLoadingImage:withImage:)])
		[[self delegate] didFinishLoadingImage:NO withImage:[self image]];

}

- (void)abortOnce {
    
    status = AsyncImageViewStatusAborted;
    
    while ([[self subviews] count]>0) {
		[[[self subviews] objectAtIndex:0] removeFromSuperview];
	}
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

@end
