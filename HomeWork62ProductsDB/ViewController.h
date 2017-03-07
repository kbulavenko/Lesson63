//
//  ViewController.h
//  HomeWork62ProductsDB
//
//  Created by  Z on 03.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "FMDB.h"
#import "MyTableViewController.h"


@interface ViewController : NSViewController
{
    MyTableViewController     *MTVC;
}

@property  MyTableViewController     *MTVC;


@property (weak) IBOutlet NSTableView *tableView;


@property (weak) IBOutlet NSButton *btnAdd;

@property (weak) IBOutlet NSButton *btnDel;

@property (weak) IBOutlet NSButton *btnEdit;


-(IBAction)btnclick:(id)sender;



@end

