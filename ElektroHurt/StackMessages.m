//
//  StackMessages.m
//  Demotuch
//
//  Created by Rafał Maślanka on 10-11-15.
//  Copyright 2010 RAFIKEL Technologie. All rights reserved.
//

#import "StackMessages.h"
#import <QuartzCore/QuartzCore.h>

@implementation StackMessages
@synthesize messages;
@synthesize heightOffset;

- (id)initWithMessageHeight:(float)height {
    messages = [[NSMutableArray alloc] initWithCapacity:0];
	self.heightOffset = 0;
	messageHeight = height;
	visible = YES;
	counter = 0;
	[self drawMessages];
	return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//	self.heightOffset = self.navigationController.toolbar.frame.size.height;
	[self drawMessages];
}

- (void)drawMessages {

	while ([[self.view subviews] count]>0)
		[[[self.view subviews] objectAtIndex:0] removeFromSuperview];
	
	if (!visible) return;
	
	float height = messageHeight * [messages count];	
	self.view.frame = CGRectMake(0, 
								 self.view.superview.bounds.size.height - height - heightOffset, 
								 self.view.superview.bounds.size.width,
								 height);

	for (NSDictionary *m in messages) {
		UILabel *messageLabel = [[UILabel alloc] initWithFrame:
								 CGRectMake(0,  height - messageHeight, self.view.frame.size.width, messageHeight)];
		messageLabel.text = [m objectForKey:@"message"];
		StackMessagesMessageType type = [[m objectForKey:@"type"] intValue];
		
		if (type==StackMessagesMessageTypeInfo) {
			messageLabel.textColor = [UIColor whiteColor];
			messageLabel.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:100.0f alpha:0.7f];
		}
		else if (type==StackMessagesMessageTypeAlert) {
			messageLabel.textColor = [UIColor blackColor];
			messageLabel.backgroundColor = [UIColor colorWithRed:100.0f green:100.0f blue:0.0f alpha:0.7f];
		}
		else if (type==StackMessagesMessageTypeError) {
			messageLabel.textColor = [UIColor whiteColor];
			messageLabel.backgroundColor = [UIColor colorWithRed:100.0f green:0.0f blue:0.0f alpha:0.7f];
		}
		else {
			messageLabel.textColor = [UIColor whiteColor];
			messageLabel.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
		}
		
		messageLabel.textAlignment = UITextAlignmentCenter;
		messageLabel.adjustsFontSizeToFitWidth = YES;
		[self.view addSubview:messageLabel];
        height-= messageHeight;
	}
	
}

- (void)removeMessage:(NSTimer *)timer {

	NSInteger idToRemove = [timer.userInfo intValue];

	int i = 0;
	for (NSDictionary *d in messages) {
		if ([[d objectForKey:@"id"] intValue]==idToRemove) {
			/*
			CATransition *animation = [CATransition animation];
			[animation setDelegate:self];
			[animation setDuration:0.3f];
			[animation setType:kCATransitionReveal];
			[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
			[[[[messagesContainerView subviews] objectAtIndex:i] layer] addAnimation:animation forKey:kCATransitionReveal];
			*/
			[messages removeObjectAtIndex:i];
			[self drawMessages];
			return;
			
		}
		i++;
	}
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
}

- (void)clearDefaultMessages {
	[self clearDefaultMessagesAndType:StackMessagesMessageTypeDefault];
}

- (void)clearDefaultMessagesAndType:(StackMessagesMessageType)type {
    if ([messages count]>0) {
        int i = 0;
        do {
            NSDictionary *d = [messages objectAtIndex:i];
            if ([[d objectForKey:@"type"] intValue]==StackMessagesMessageTypeDefault || [[d objectForKey:@"type"] intValue]==type) {
				/*
				 [NSTimer scheduledTimerWithTimeInterval:0.1f
				 target:self 
				 selector:@selector(removeMessage:)
				 userInfo:[d objectForKey:@"id"] 
				 repeats:NO];
				 i++
				 */
				[messages removeObjectAtIndex:i];
				break;
			}
            else i++;
        } while (i<[messages count]);
    }    
}

- (void)addMessage:(NSString *)message type:(StackMessagesMessageType)type {
	
	// zwiększamy licznik
	counter++;
    
    // usuwamy defaultowe wiadomości
	[self clearDefaultMessagesAndType:type];
	
	// dodajemy nowy na końcu
	NSDictionary *m = [[NSDictionary alloc] initWithObjectsAndKeys:
					   [NSNumber numberWithInt:counter], @"id",
					   [NSNumber numberWithInt:type], @"type",
					   message, @"message",
					   nil];
	[messages addObject:m];
	
	// automatyczne usunięcie
	if (type!=StackMessagesMessageTypeDefault) {
		float interval = 2.5 * (type>0?1:0);
        [NSTimer scheduledTimerWithTimeInterval:interval
										 target:self 
									   selector:@selector(removeMessage:)
									   userInfo:[NSString stringWithFormat:@"%d",counter] 
										repeats:NO];
	}
	
	// rysujemy na nowo
	[self drawMessages];
	
}

- (void)startStack {
	visible = YES;
	[self drawMessages];
}

- (void)stopStack {
	visible = NO;
	[self drawMessages];
}

@end
