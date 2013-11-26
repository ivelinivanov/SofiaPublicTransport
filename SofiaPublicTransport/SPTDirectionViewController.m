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
{
    NSArray *forwardDirectionStations;
    NSArray *backwardDirectionStations;
    NSString *forwardDirectionName;
    NSString *backwardDirectionName;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SPTDirectionViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.activityIndicator startAnimating];
    
    [SPTUpdateManager getListOfStationsForLine:self.lineNumber type:self.lineType completion:^(NSString *forward, NSArray *first, NSString *backward, NSArray *second) {
        forwardDirectionName = forward;
        backwardDirectionName = backward;
        forwardDirectionStations = first;
        backwardDirectionStations = second;
        
        [self.activityIndicator stopAnimating];
    }];
}

@end
