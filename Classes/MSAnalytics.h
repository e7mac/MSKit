//
//  MSAnalytics.h
//  bent.fm
//
//  Created by Mayank on 8/26/15.
//  Copyright (c) 2015 Mayank Sanganeria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAnalytics : NSObject

+ (void)initializeAllServicesWithKeys:(NSDictionary *)keys;

+ (void)setupUserId:(NSString *)userid;
+ (void)setupUserProperties:(NSDictionary *)properties;

+ (void)trackCharge:(NSNumber *)charge;

+ (void)track:(NSString *)event;
+ (void)track:(NSString *)event properties:(NSDictionary *)properties;

@end
