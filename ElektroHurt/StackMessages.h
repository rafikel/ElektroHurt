//
//  StackMessages.h
//  Demotuch
//
//  Created by Rafał Maślanka on 10-11-15.
//  Copyright 2010 RAFIKEL Technologie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	StackMessagesMessageTypeDefault = 0,
	StackMessagesMessageTypeInfo,
	StackMessagesMessageTypeAlert,
	StackMessagesMessageTypeError
} StackMessagesMessageType;

@interface StackMessages : UIViewController {
	BOOL visible;
	NSInteger counter;
	NSMutableArray *messages;
	NSInteger messageHeight;
	float heightOffset;
}

@property (nonatomic, retain) NSMutableArray *messages;
@property (nonatomic) float heightOffset;

- (void)drawMessages;
- (id)initWithMessageHeight:(float)height;
- (void)addMessage:(NSString *)message type:(StackMessagesMessageType)type;
- (void)clearDefaultMessages;
- (void)clearDefaultMessagesAndType:(StackMessagesMessageType)type;
- (void)stopStack;
- (void)startStack;

@end
