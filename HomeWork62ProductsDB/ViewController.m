//
//  ViewController.m
//  HomeWork62ProductsDB
//
//  Created by  Z on 03.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "ViewController.h"



@implementation ViewController
@synthesize MTVC,tableView,btnAdd,btnDel,btnEdit;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    srand((unsigned int)time(NULL));
    NSArray    *choco  = @[ @"Mars", @"Snikers", @"Twix", @"Bounty", @"Alenka", @"ChocoBoom", @"M&Ms", @"Corona", @"Lion", @"Bueno", @"Corny", @"Kit-Kat", @"Nuts"];
    
    
    NSString   *dbPath  =  [NSString   stringWithFormat:@"%@/Documents/second.db", NSHomeDirectory()];
    NSLog(@"%@", dbPath);
    FMDatabase      *db    =   [FMDatabase databaseWithPath: dbPath];
    if(![db open])
    {
        NSLog(@"Ошибка открытия базы!");
        exit(-1);
    }
    if(![db goodConnection])
    {
        NSLog(@"Ошибка соединения с базой!");
        exit(-1);
    }
    [db executeUpdate: @"DROP TABLE IF EXISTS products;"];
   NSLog(@"%@", [db lastError]);
    [db executeUpdate: @"CREATE TABLE IF NOT EXISTS products (id integer not null  primary key , name varchar[500], weight integer, price double);"];
    NSLog(@"%@", [db lastError]);
    NSString    *strInsert  =   @"INSERT INTO products (name, weight, price) VALUES (%@, %i, %f);";
    for (int i = 0; i < 1000; i++)
    {
        NSString    *name  =   [NSString   stringWithFormat:@"%@-%i",  [choco   objectAtIndex: rand() % 13], rand() % 1024 ];
        int         weight =  5 *( 4+ rand()% 16);
        double      price  = 10.0 + (double) (rand() % 1024) / 100.0;
        
        [db executeUpdateWithFormat: strInsert, name, weight, price];
        
        
    }
    FMResultSet	*result = [db executeQuery : @"SELECT * FROM products"];
    while([result next])
    {
//        NSLog(@"Product with ID : \t%i \tis \t%24@ \t\t%i \t%3.2f.",
//              [result intForColumn : @"id"],
//              [result stringForColumn : @"name"],
//              [result intForColumn : @"weight"],
//              [result doubleForColumn : @"price"]);
    }
    [result close];
    [db close];
    
    self.MTVC   =  [[MyTableViewController  alloc]  initWithDBPath: dbPath];
   // [NSThread  sleepForTimeInterval: 0.5];
    self.tableView.dataSource   = self.MTVC;
    
    
    NSNotificationCenter    *NC = [NSNotificationCenter  defaultCenter];
    [NC addObserver: self selector: @selector(tableViewReload:) name:MyTableViewControllerBufferRotationNeedTableViewReload object: self.MTVC];
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


-(IBAction)btnclick:(id)sender
{
    
}

-(void)tableViewReload:(NSEvent *)theEvent
{
    [self.tableView reloadData];
}


@end
