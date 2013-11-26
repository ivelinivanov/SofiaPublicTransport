//
//  SPTUpdateManager.h
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/25/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "SPTStation.h"

@interface SPTUpdateManager : NSObject

+ (void)getListOfStationsForLine:(NSString *)line type:(NSUInteger)type completion:(void(^)(NSString *forward, NSArray *first, NSString *backward, NSArray *second))completion;
+ (void)getTimeForStation:(SPTStation *)station type:(NSUInteger)type completion:(void(^)(NSString *msg))completion;

@end
