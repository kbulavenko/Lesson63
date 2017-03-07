//
//  MyTableViewController.m
//  HomeWork62ProductsDB
//
//  Created by  Z on 03.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyTableViewController.h"

@interface   MyTableViewController()

-(void)loadDataFromDB;

@end


@implementation MyTableViewController
//@synthesize  db,startRow,

- (instancetype)initWithDBPath: (NSString  *) path
{
    self = [super init];
    if (self) {
        self->countRows   = 1000;
        self->endRow      = self->countRows + 1;
        self->startRow   = -1000;      //  Инициализируем в значение которое не попадет в диапазхон [startRow ; startRow + countRows];
        // чтобы обязательно вызвать
        self->arrRow    = [NSMutableArray array];
        
        self->db  = [FMDatabase  databaseWithPath: path];
        if(self->db == nil)
        {
            return nil;
        }
        
        self->cmdInsert   =  @"INSERT INTO products (name, price, weight) VALUSES (?, ? , ?)";
        self->cmdDelete   =  @"DELETE FROM products WHERE id = ?";
        self->cmdUpdate   =  @"UPDATE products SET name = ?, price = ?, weight = ? WHERE id = ?";
        
        
        
        [self->db open];
        [self loadDataFromDB];
        
//        for (int i = 0; <#condition#>; <#increment#>) {
//            <#statements#>
//        }
        
    }
    return self;
}

- (void)dealloc
{
    [self->db close];
    [self->arrRow  removeAllObjects];
}

#pragma mark    Data Source Methods


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  //  return   self->countRows + self->startRow ;
    
    FMResultSet   *res  =   [db executeQuery:@"SELECT COUNT(*) AS cnt FROM products"];
    if([res next])
    {
        return [res intForColumn:@"cnt"];
    }
    else
    {
        return 0;
    }
}

/* This method is required for the "Cell Based" TableView, and is optional for the "View Based" TableView. If implemented in the latter case, the value will be set to the view at a given row/column if the view responds to -setObjectValue: (such as NSControl and NSTableCellView).
 */
/*
- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
   // return @"fgsdfs";
//    if((self->startRow  + row ) % 150 > 70 )
//    {
//        self->startRow  +=  50;
//    }
    //
    NSUInteger    maxNumberOfRowInDB   =  [db longForQuery:@"SELECT COUNT(id) FROM products"];
   // NSLog(@"maxNumberOfRowInDB = %lu", maxNumberOfRowInDB);
    if(row > (self->startRow + self->countRows * 2 / 3)  && (self->endRow + self->countRows * 1 / 3) > maxNumberOfRowInDB)
    {
        NSLog(@"Дошли до верхнего предела");
        self->startRow  += self->countRows / 3;
        self->endRow    = (int) maxNumberOfRowInDB;
        [self reloadDataFromDB];
    }
    else
    if( row > (self->startRow + self->countRows * 2 / 3))
    {
        NSLog(@"row = %li", row);
        
        self->startRow  += self->countRows / 3;
        self->endRow    += self->countRows / 3;
        [self reloadDataFromDB];
        
        NSNotificationCenter    *NC   = [NSNotificationCenter  defaultCenter];
        [NC  postNotificationName: MyTableViewControllerBufferRotationNeedTableViewReload   object: self];
    }
    
   // NSLog(@"row = %li", row);
    if([tableColumn.identifier isEqualToString: @"id"])
    {
        
      //  NSTableCellView   *retView  = [tableView makeViewWithIdentifier:@"id" owner: self];
        return [self->arrRow  objectAtIndex:  row ][@"id"];
    }
    if([tableColumn.identifier isEqualToString: @"name"])
    {
       // NSString   *str   =  [[self->arrRow  objectAtIndex: row] objectForKey:@"name"];
      //  NSLog(@"[self->arrRow  objectAtIndex: row],@[@\"name\"] =%@б row = %li, str = %@", ([self->arrRow  objectAtIndex: row][@"name"]), row, str);
        return [self->arrRow  objectAtIndex: row ][@"name"];
    }
    if([tableColumn.identifier isEqualToString:   @"weight"])
    {
        return [self->arrRow  objectAtIndex:   row ][@"weight"];
    }
    if([tableColumn.identifier isEqualToString: @"price"])
    {
        return [self->arrRow  objectAtIndex: row ][@"price"];
    }
    return nil;
}
*/
#pragma mark -
#pragma mark ***** Optional Methods *****

/* NOTE: This method is not called for the View Based TableView.
 */
//-(void)tableView:(NSTableView *)tableView setObjectValue:(nullable id)object forTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
//{
//
//}

//static   int count1  = 0;
- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
   //
    if([tableColumn.identifier isEqualToString: @"id"])
    {
        return [self->arrRow  objectAtIndex:  row ][@"id"];

        return [NSString  stringWithFormat: @"id %li ",row ];
    }
    if([tableColumn.identifier isEqualToString: @"name"])
    {
        return [self->arrRow  objectAtIndex: row ][@"name"];
        return @"name";
    }
    if([tableColumn.identifier isEqualToString: @"price"])
    {
        
        return [self->arrRow  objectAtIndex: row ][@"price"];
        return @"00.00";
    }
    if([tableColumn.identifier isEqualToString: @"weight"])
    {
        return [self->arrRow  objectAtIndex:   row ][@"weight"];
        return  @"000";
    }
    return @"Пусто!";
}


-(void)loadDataFromDB
{
    
    [self->db open];
    
    //  FMResultSet	*result = [self->db executeQuery :[NSString    stringWithFormat:  @"SELECT * FROM products  LIMIT %i WHERE ID >= %i AND ID < %i",self->countRows, self->startRow, self->startRow + self->countRows]];
    NSLog(@"%@", [NSString    stringWithFormat:  @"SELECT * FROM products   WHERE ID >= %i AND ID <= %i LIMIT %i", self->startRow, self->startRow + self->countRows , /*self->countRows*/ 1000]);
    FMResultSet	*result = [self->db executeQuery : [NSString    stringWithFormat:  @"SELECT * FROM products   WHERE ID >= %i AND ID <= %i LIMIT %i", self->startRow, self->startRow + self->countRows , /*self->countRows*/ 1000]];
    int count  = 0;
    while([result next] && count < self->countRows)
    {
        
        [self->arrRow   addObject: @{ @"id"     :   @([result intForColumn      : @"id"]),
                                      @"name"   :   [result stringForColumn     : @"name"],
                                      @"weight" :   @([result intForColumn      : @"weight"]),
                                      @"price"  :   @([result doubleForColumn   : @"price"])
                                      }];
        count++;
    }
    [result close];

}



-(void)reloadDataFromDB
{
    
    [self->db open];
    
    //  FMResultSet	*result = [self->db executeQuery :[NSString    stringWithFormat:  @"SELECT * FROM products  LIMIT %i WHERE ID >= %i AND ID < %i",self->countRows, self->startRow, self->startRow + self->countRows]];
    NSLog(@"%@", [NSString    stringWithFormat:  @"SELECT * FROM products   WHERE ID > %i AND ID <= %i LIMIT %i", self->startRow , self->endRow , self->endRow  - self->startRow]);
    FMResultSet	*result = [self->db executeQuery : [NSString    stringWithFormat:  @"SELECT * FROM products   WHERE ID > %i AND ID <= %i LIMIT %i", self->startRow  + 2 * self->countRows / 3, self->endRow + + 2 * self->countRows / 3 + 1, self->endRow  - self->startRow]];
    int count  = 0;
    while([result next] && count < (self->countRows /3))
    {
        
        [self->arrRow   addObject: @{ @"id"     :   @([result intForColumn      : @"id"]),
                                      @"name"   :   [result stringForColumn     : @"name"],
                                      @"weight" :   @([result intForColumn      : @"weight"]),
                                      @"price"  :   @([result doubleForColumn   : @"price"])
                                      }];
        count++;
    }
    [result close];
    
}

-(NSDictionary*) getRowAtШndex  : (int) index
{
//   Проверки:
    // 1. Запрашиваема строка ВООБЩЕ не из буфера
    // 2. Запрашиваема строка НЕ ИЗ ЦЕНТРА БУФЕРА
    
    if(index < self->startRow || index >= self->startRow + self->countRows)
    {
        [self reloadBuffer: index - (index % self->countRows)];
    }
    return [self->arrRow  objectAtIndex: index  - self->startRow];
    
//    if(index >= self->startRow  && index < self->startRow + self->countRows)
//    {
//        return [self->arrRow   objectAtIndex: (index - self->startRow)];
//    }
//    else
//    {
//        //   -- Необходимо обновить буфер arrRow новыми значениями
//        int    strRow  = (index % self->countRows);
//        FMResultSet    *res   = [self->db executeQuery:@""];
//    }
    
    return nil;
}

-(void) reloadBuffer  : (int) startIndex
{
    [self->arrRow  removeAllObjects];
    FMResultSet  *result   =  [self->db executeQuery:@"SELECT * FROM products LIMIT ?, ?", self->startRow, self->countRows];
    while ([result next])
    {
        NSDictionary *dict  =  @{ @"id"     :   @([result intForColumn      : @"id"]),
                                                @"name"   :   [result stringForColumn     : @"name"],
                                                @"weight" :   @([result intForColumn      : @"weight"]),
                                                @"price"  :   @([result doubleForColumn   : @"price"])
                                                };
        [self->arrRow  addObject: dict];

    }
    [result close];
}


@end
