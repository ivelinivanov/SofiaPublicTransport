//
//  SPTUpdateManager.m
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/25/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import "SPTUpdateManager.h"
#import "HTMLParser.h"
#import "SPTStation.h"

@implementation SPTUpdateManager

+ (void)getListOfStationsForLine:(NSString *)line type:(NSUInteger)type completion:(void (^)(NSString *, NSArray *, NSString *, NSArray *))completion
{
    NSString *stationsURL = [NSString stringWithFormat:@"http://m.sofiatraffic.bg/schedules?tt=%d&ln=%@&s=%%D0%%A2%%D1%%8A%%D1%%80%%D1%%81%%D0%%B5%%D0%%BD%%D0%%B5", type + 1, line];
    NSURL *url = [NSURL URLWithString:stationsURL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        NSLog(@"%@", html);
        
        HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
        
        HTMLNode *bodyNode = [parser body];
        
        NSMutableArray *forwardStations = [[NSMutableArray alloc] init];
        NSMutableArray *backwardStations = [[NSMutableArray alloc] init];
        
        NSString *forwardDirectionName;
        NSString *backwardDirectionName;
        
        NSArray *forms = [bodyNode findChildTags:@"form"];

        NSLog(@"Forms: %d", forms.count);

        NSInteger i = 0;
        
        for (HTMLNode *form in forms)
        {
            NSArray *options = [form findChildTags:@"option"];
            
            NSArray *hiddenCodes = [form findChildTags:@"input"];
            
            NSString *lid;
            NSString *rid;
            
            for (HTMLNode *inputNode in hiddenCodes)
            {
                if ([[inputNode getAttributeNamed:@"type"] isEqualToString:@"hidden"] && [[inputNode getAttributeNamed:@"name"] isEqualToString:@"lid"])
                {
                    lid = [inputNode getAttributeNamed:@"value"];
                }
                if ([[inputNode getAttributeNamed:@"type"] isEqualToString:@"hidden"] && [[inputNode getAttributeNamed:@"name"] isEqualToString:@"rid"]) {
                    rid = [inputNode getAttributeNamed:@"value"];
                }
            }
            
            for (HTMLNode *option in options)
            {
                SPTStation *newStation = [[SPTStation alloc] init];
                newStation.name = [[option contents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                newStation.code = [option getAttributeNamed:@"value"];
                newStation.lid = lid;
                newStation.rid = rid;
                
                if (i == 0)
                {
                    [forwardStations addObject:newStation];
                }
                else
                {
                    [backwardStations addObject:newStation];
                }
            }
            
            HTMLNode *divNode = [form findChildTag:@"div"];
            
            if (i == 0)
            {
                forwardDirectionName = [divNode contents];
            }
            else
            {
                backwardDirectionName = [divNode contents];
            }
            
            i++;
        }
        
        NSLog(@"%d %d", forwardStations.count, backwardStations.count);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(forwardDirectionName, forwardStations, backwardDirectionName, backwardStations);
        });
    });
}

@end
