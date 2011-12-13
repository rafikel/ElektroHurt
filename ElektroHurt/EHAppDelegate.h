//
//  EHAppDelegate.h
//  ElektroHurt
//
//  Created by Rafał Maślanka on 13.12.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EHViewController;

@interface EHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EHViewController *viewController;

@end
