//
//  MSAnalytics.m
//  bent.fm
//
//  Created by Mayank on 8/26/15.
//  Copyright (c) 2015 Mayank Sanganeria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mixpanel.h>
#import <Amplitude.h>

@implementation MSAnalytics

+ (void)initializeAllServicesWithKeys:(NSDictionary *)keys
{
  if ([keys objectForKey:@"mixpanel"]) {
    [Mixpanel sharedInstanceWithToken:keys[@"mixpanel"]];
    [[Mixpanel sharedInstance] identify:[Mixpanel sharedInstance].distinctId];
    [[Mixpanel sharedInstance].people increment:@"App open" by:@1];
  }
  if ([keys objectForKey:@"amplitude"]) {
    [[Amplitude instance] initializeApiKey:keys[@"amplitude"]];
  }
}

+ (void)setupUserId:(NSString *)userid
{
  [[Mixpanel sharedInstance] identify:userid];
  [[Amplitude instance] setUserId:userid];
}
+ (void)setupUserProperties:(NSDictionary *)properties
{
  [[Mixpanel sharedInstance].people set:properties];
  [[Amplitude instance] setUserProperties:properties];
}

+ (void)trackCharge:(NSNumber *)charge
{
  [[Amplitude instance] logRevenue:charge];
  //  [[Mixpanel sharedInstance] trackCharge:charge];
}


+ (void)track:(NSString *)event
{
  [[Mixpanel sharedInstance] track:event];
  [[Amplitude instance] logEvent:event];
}

+ (void)track:(NSString *)event properties:(NSDictionary *)properties
{
  [[Mixpanel sharedInstance] track:event properties:properties];
  [[Amplitude instance] logEvent:event withEventProperties:properties];
}

@end
