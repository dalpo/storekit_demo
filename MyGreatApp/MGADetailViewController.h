//
//  MGADetailViewController.h
//  MyGreatApp
//
//  Created by Andrea Dal Ponte on 08/11/13.
//  Copyright (c) 2013 Develon srl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGADetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
