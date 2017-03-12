//
//  MyOneRowView.m
//  HomeWork62ProductsDB
//
//  Created by Z on 09.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyOneRowView.h"

@interface MyOneRowView ()

@end

@implementation MyOneRowView
@synthesize name, weight, price, btnOk, btnCancel, readResult;


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil operationType: (BOOL) ot  editValues: (NSDictionary *) ev

{
    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil)
    {
        self->isOperationEdit   = ot;
        self->editValues        = ev;
        
        if(self->isOperationEdit )
        {
          //  NSLog(@"ev = %@", ev);
          //  self->name.stringValue   = [ self->editValues[@"name"] copy];
          //  self->weight.stringValue   = [ self->editValues[@"weight"] copy];
          //  self->price.stringValue   = [ self->editValues[@"price"] copy];
            //NSLog(@"self->editValues[@\"name\"] =  %@", self->editValues[@"name"]);
            
            
        }
        
    }
    return self;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
   // self.name.stringValue   = @"";
}

- (IBAction)btnClick:(id)sender
{
    ///
    if(sender == btnOk)
    {
       // [self      removeFromParentViewController];
        
        if(self.weight.stringValue.intValue == 0 || self.price.stringValue.doubleValue == 0.0 || self.name.stringValue.length == 0)
        {
            NSAlert   *alert  = [NSAlert  new];
            alert.messageText   = @"Ошибка!";
            alert.informativeText  = @"Данные введены неверно!";
            alert.alertStyle    = NSCriticalAlertStyle;
            [alert runModal];
            
            return;
        }
        
        
        self->readResult   =   @{
                                 @"name"     :   self.name.stringValue.copy,
                                 @"weight"   :   self.weight.stringValue.copy,
                                 @"price"     :   self.price.stringValue.copy
                                 
                                 };
        
        NSNotificationCenter    *NC  =   [NSNotificationCenter defaultCenter];
        
        
        if(self->isOperationEdit)
        {
            [NC   postNotificationName: MyOneRowViewDataReadyUpdateNotification object: self userInfo: self->readResult];
        }
        else
        {
            [NC   postNotificationName: MyOneRowViewDataReadyAddNotification object: self userInfo: self->readResult];
        }
        
        
        [self.view.window close];
     //   [self.view removeFromSuperview];
     //   [self      removeFromParentViewController];

    }
    else
    if(sender == btnCancel)
    {
        [self.view.window close];
    //    [self.view removeFromSuperview];
    //    [self      removeFromParentViewController];
    }
}
@end
