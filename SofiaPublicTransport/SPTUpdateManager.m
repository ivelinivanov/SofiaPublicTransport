//
//  SPTUpdateManager.m
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/25/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import "SPTUpdateManager.h"

@implementation SPTUpdateManager

+ (void)getListOfStationsForLine:(NSString *)line type:(NSUInteger)type completion:(void (^)(NSArray *))completion
{
    NSString *stationsURL = [NSString stringWithFormat:@"http://m.sofiatraffic.bg/schedules?tt=%d&ln=%@&s=%%D0%%A2%%D1%%8A%%D1%%80%%D1%%81%%D0%%B5%%D0%%BD%%D0%%B5", type, line];
    NSURL *url = [NSURL URLWithString:stationsURL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", html);
    });
}

@end
