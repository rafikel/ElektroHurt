//
//  AsyncImageView.h
//
//  Created by Rafał Maślanka on 10-11-08.
//  Copyright (c) 2010 RAFIKEL Technologie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	AsyncImageViewStatusDefault = 0,
	AsyncImageViewStatusProcessing,
	AsyncImageViewStatusAborted,
	AsyncImageViewStatusError,
    AsyncImageViewStatusOK
} AsyncImageViewStatus;

typedef enum {
	AsyncImageViewErrorTypeNone = 0,
	AsyncImageViewErrorTypeConnectionBad,
	AsyncImageViewErrorTypeConnectionLost,
	AsyncImageViewErrorTypeBadType,
	AsyncImageViewErrorTypeBadSize,
	AsyncImageViewErrorTypeOther
} AsyncImageViewErrorType;

@protocol AsyncImageViewDelegate <NSObject>
@optional
- (void)didFinishLoadingImage:(BOOL)success withImage:(UIImage *)image;
@end

@interface AsyncImageView : UIView {

    id<AsyncImageViewDelegate> delegate;
    
	NSURLConnection* connection;
	NSMutableData* data;
    
    NSString *imagePath;
    NSString *tempPath;
    
    AsyncImageViewStatus status;
	AsyncImageViewErrorType errorType;
    NSInteger size;
    NSInteger received;
    
    UIImageView *imageView;
	UIActivityIndicatorView *spinnerView;
    UIProgressView *progressView;
	
}

@property (nonatomic, strong) id<AsyncImageViewDelegate> delegate;
@property (nonatomic, readonly) AsyncImageViewStatus status;
@property (nonatomic, readonly) AsyncImageViewErrorType errorType;
@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic, retain) NSString *tempPath;

- (void)reloadImage;
- (void)loadImage;
- (void)cancelLoadImage;
- (void)loadImageFromPath:(NSString *)path;
- (BOOL)loadImageFromTemp:(NSString *)path;
- (void)refreshWithFrame:(CGRect)frame;
- (UIImage *)image;
- (void)error;
- (void)abortOnce;

@end
