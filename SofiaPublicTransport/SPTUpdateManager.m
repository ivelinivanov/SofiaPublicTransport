//
//  SPTUpdateManager.m
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/25/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import "SPTUpdateManager.h"
#import "HTMLParser.h"

@implementation SPTUpdateManager

+ (void)getListOfStationsForLine:(NSString *)line type:(NSUInteger)type completion:(void (^)(NSArray *, NSArray *))completion
{
    NSString *stationsURL = [NSString stringWithFormat:@"http://m.sofiatraffic.bg/schedules?tt=%d&ln=%@&s=%%D0%%A2%%D1%%8A%%D1%%80%%D1%%81%%D0%%B5%%D0%%BD%%D0%%B5", type, line];
    NSURL *url = [NSURL URLWithString:stationsURL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        HTMLNode *bodyNode = [parser body];
        
        NSArray *selectNodes = [bodyNode findChildTags:@"select"];

        for (HTMLNode *node in selectNodes)
        {
            NSLog(@"node");
        }
        
//        NSLog(@"%@", html);
    });
}

@end
