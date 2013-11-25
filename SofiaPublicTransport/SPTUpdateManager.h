//
//  SPTUpdateManager.h
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/25/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface SPTUpdateManager : NSObject

+ (void)getListOfStationsForLine:(NSString *)line type:(NSUInteger)type completion:(void(^)(NSArray *list))completion;

@end
