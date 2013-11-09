//
//  MGAStoreViewController.h
//  MyGreatApp
//
//  Created by Andrea Dal Ponte on 08/11/13.
//  Copyright (c) 2013 Develon srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface MGAStoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SKProductsRequestDelegate, SKPaymentTransactionObserver>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
