//
//  SPTDirectionViewController.m
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/25/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import "SPTDirectionViewController.h"
#import "SPTUpdateManager.h"

@interface SPTDirectionViewController ()

@end

@implementation SPTDirectionViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SPTUpdateManager getListOfStationsForLine:self.lineNumber type:self.lineType completion:^(NSArray *first, NSArray *second) {
        
    }];
}

@end
