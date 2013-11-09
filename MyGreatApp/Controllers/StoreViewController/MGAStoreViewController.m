//
//  MGAStoreViewController.m
//  MyGreatApp
//
//  Created by Andrea Dal Ponte on 08/11/13.
//  Copyright (c) 2013 Develon srl. All rights reserved.
//

#import "MGAStoreViewController.h"


@interface MGAStoreViewController ()

@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) SKProductsRequest *request;

@end

@implementation MGAStoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // com.develon.MyGreatApp.MyFeatures
    
    NSSet *identifiers = [NSSet setWithObject:@"com.develon.MyGreatApp.MyFeatures"];
    
    self.request = [[SKProductsRequest alloc] initWithProductIdentifiers: identifiers];
    self.request.delegate = self;
    [self.request start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Store kit

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    if (response.products.count > 0)
    {
        self.products = response.products;
        [self.tableView reloadData];
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", error);
}

// table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cella"];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cella"];
    }
    
    SKProduct *product = self.products[indexPath.row];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:product.priceLocale];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    cell.textLabel.text       = [NSString stringWithFormat:@"%@, %@ €", product.localizedTitle, [formatter stringFromNumber:product.price]];
    cell.detailTextLabel.text = product.localizedDescription;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SKProduct *product = self.products[indexPath.row];
    
    if ([SKPaymentQueue canMakePayments])
    {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }   
}

// payments

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                break;

            case SKPaymentTransactionStateFailed:
                break;
                
            case SKPaymentTransactionStateRestored:
                break;
                
            case SKPaymentTransactionStatePurchasing:
                break;
                
            default:
                break;
        }
    }
}

@end
