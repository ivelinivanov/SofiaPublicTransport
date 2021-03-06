//
//  SPTInitialViewController.m
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/25/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import "SPTInitialViewController.h"
#import "SPTDirectionViewController.h"

@interface SPTInitialViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *transportSegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

- (IBAction)searchPressed:(id)sender;
@end

@implementation SPTInitialViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.numberTextField becomeFirstResponder];
}

#pragma mark - IBAction Methods

- (IBAction)searchPressed:(id)sender
{
    if ([self.numberTextField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Не сте въвели номер на линия!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
    else
    {
        [self performSegueWithIdentifier:@"toDirectionViewController" sender:self];
    }
}

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[SPTDirectionViewController class]])
    {
        SPTDirectionViewController *destinationController = (SPTDirectionViewController *)[segue destinationViewController];
        [destinationController setLineType:self.transportSegmentControl.selectedSegmentIndex];
        [destinationController setLineNumber:self.numberTextField.text];
    }
}

@end
