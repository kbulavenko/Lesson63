//
//  MyOneRowView.h
//  HomeWork62ProductsDB
//
//  Created by Z on 09.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Cocoa/Cocoa.h>

static   NSString   *MyOneRowViewDataReadyAddNotification  = @"MyOneRowViewDataReadyAddNotification";
static   NSString   *MyOneRowViewDataReadyUpdateNotification  = @"MyOneRowViewDataReadyUpdateNotification";


@interface MyOneRowView : NSViewController
{
    BOOL            isOperationEdit;
    NSDictionary    *editValues;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil operationType: (BOOL) ot  editValues: (NSDictionary *) ev;

@property (strong, nonatomic)   NSDictionary      *readResult;

@property (weak) IBOutlet NSTextField *name;

@property (weak) IBOutlet NSTextField *weight;

@property (weak) IBOutlet NSTextField *price;


@property (weak) IBOutlet NSButton *btnOk;


@property (weak) IBOutlet NSButton *btnCancel;

- (IBAction)btnClick:(id)sender;




@end
