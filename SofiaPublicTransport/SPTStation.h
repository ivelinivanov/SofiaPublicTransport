//
//  SPTStation.h
//  SofiaPublicTransport
//
//  Created by Ivelin Ivanov on 11/26/13.
//  Copyright (c) 2013 Ivelin Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPTStation : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *lid;
@property (strong, nonatomic) NSString *rid;

@end
