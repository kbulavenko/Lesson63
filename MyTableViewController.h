//
//  MyTableViewController.h
//  HomeWork62ProductsDB
//
//  Created by  Z on 03.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import <Cocoa/Cocoa.h>

static  NSString   *MyTableViewControllerBufferRotationNeedTableViewReload = @"MyTableViewControllerBufferRotationNeedTableViewReload";

@interface MyTableViewController : NSObject<NSTableViewDataSource>
{
    FMDatabase                          *db;
    int                                 startRow;   // Номер стартовой строки из буфера
    NSMutableArray<NSDictionary *>      *arrRow;   // Буфер
    int                                 countRows;
    int                                 endRow;    // Номер конечной строки в диапазоне
    
    NSString                            *cmdInsert;
    NSString                            *cmdDelete;
    NSString                            *cmdUpdate;
   // NSMutableArray                      *count1;
    
}


//@property       FMDatabase                          *db;
//@property       int                                 startRow;
//@property       NSMutableArray<NSDictionary *>      *arrRow;
//@property       int                                 countRows;



-(instancetype)initWithDBPath:  (NSString *)   path;
-(void)dealloc;
-(NSDictionary*) getRowAtIndex  : (int) index;
//-(void)loadDataFromDB;
-(void) reloadBuffer  : (int) startIndex;


@end
