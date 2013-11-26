//
//  SPTDirectionViewController.m
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/25/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import "SPTDirectionViewController.h"
#import "SPTUpdateManager.h"
#import "SPTStation.h"

@interface SPTDirectionViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>
{
    NSArray *forwardDirectionStations;
    NSArray *backwardDirectionStations;
    NSString *forwardDirectionName;
    NSString *backwardDirectionName;
    
    NSArray *pickerDataSource;
}

@property (weak, nonatomic) IBOutlet UILabel *directionNameLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *stationPickerView;

- (IBAction)changeDirectionPressed:(id)sender;
- (IBAction)getTimeOfArrivalPressed:(id)sender;

@end

@implementation SPTDirectionViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SPTUpdateManager getListOfStationsForLine:self.lineNumber type:self.lineType completion:^(NSString *forward, NSArray *first, NSString *backward, NSArray *second) {
        if (forward && backward && first && second)
        {
            forwardDirectionName = forward;
            backwardDirectionName = backward;
            forwardDirectionStations = first;
            backwardDirectionStations = second;
            
            self.directionNameLabel.text = forwardDirectionName;
            pickerDataSource = first;
            
            [self.stationPickerView reloadAllComponents];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Упс!" message:@"Няма данни за тази линия!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
    }];
}

#pragma mark - PickerView Delegate & Datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerDataSource count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    SPTStation *station = (SPTStation *)pickerDataSource[row];
    return station.name;
}

#pragma mark - IBAction Methods

- (IBAction)changeDirectionPressed:(id)sender
{
    if ([pickerDataSource isEqual:forwardDirectionStations])
    {
        pickerDataSource = backwardDirectionStations;
        self.directionNameLabel.text = backwardDirectionName;
    }
    else
    {
        pickerDataSource = forwardDirectionStations;
        self.directionNameLabel.text = forwardDirectionName;
    }
    
    [self.stationPickerView reloadAllComponents];
}

- (IBAction)getTimeOfArrivalPressed:(id)sender
{
    [SPTUpdateManager getTimeForStation:pickerDataSource[[self.stationPickerView selectedRowInComponent:0]] type:self.lineType completion:^(NSString *msg) {
        
        NSString *stationName = [(SPTStation *)pickerDataSource[[self.stationPickerView selectedRowInComponent:0]] name];
        NSString *alertMsg = [NSString stringWithFormat:@"Линия: %@ \nСпирка: %@ \nВреме: %@ \n", self.lineNumber, stationName, msg];
        
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Време на пристигане:"
                                                       message:alertMsg
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles: nil];
        [alert show];
    }];
}

#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
