//
//  EHViewController.h
//  ElektroHurt
//
//  Created by Rafał Maślanka on 13.12.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackMessages.h"
#import "AsyncImageView.h"

@interface EHViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIButton *button;
    IBOutlet UISwitch *switcher;
    IBOutlet UISearchBar *search;
    IBOutlet UIBarButtonItem *toggleButton;
    IBOutlet UIButton *searchAnuler;
    NSMutableArray *items;
    NSInteger selectedItem;
    StackMessages *stackMessages;
    NSURLConnection *conn;
    NSMutableData *dynamicData;
    NSInteger processingRow;
    NSInteger dataSizeAll;
    NSInteger dataSizeReceived;
    NSMutableDictionary *itemsThumbnail;
    UIPickerView *doublePicker;
    NSInteger actionSheetType;
    NSInteger zlote;
    NSInteger grosze;
    NSString *urlToAdd;
}

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) IBOutlet UISwitch *switcher;
@property (nonatomic, retain) IBOutlet UISearchBar *search;
@property (nonatomic, retain) IBOutlet UIButton *searchAnuler;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *toggleButton;
@property (nonatomic, retain) UIPickerView *doublePicker;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)switchPressed:(id)sender;
- (IBAction)backgroundPressed:(id)sender;
- (IBAction)toggleEdit:(id)sender;
- (IBAction)addPressed:(id)sender;
- (IBAction)newPressed:(id)sender;
- (BOOL)loadFile;
- (BOOL)saveFile;

@end
