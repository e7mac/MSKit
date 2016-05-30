////
////  MSAnalytics.m
////  bent.fm
////
////  Created by Mayank on 8/26/15.
////  Copyright (c) 2015 Mayank Sanganeria. All rights reserved.
////
//
//#import "MSAnalytics.h"
//#import <Foundation/Foundation.h>
//#import <Mixpanel.h>
//#import <Amplitude.h>
////#import <Leanplum.h>
//
//@implementation MSAnalytics
//
//+ (void)initializeAllServicesWithKeys:(NSDictionary *)keys
//{
//  if ([keys objectForKey:@"mixpanel"]) {
//    [Mixpanel sharedInstanceWithToken:keys[@"mixpanel"]];
//    [[Mixpanel sharedInstance] identify:[Mixpanel sharedInstance].distinctId];
//    [[Mixpanel sharedInstance].people increment:@"App open" by:@1];
//  }
//  if ([keys objectForKey:@"amplitude"]) {
//    [[Amplitude instance] initializeApiKey:keys[@"amplitude"]];
//  }
//  if ([keys objectForKey:@"leanplum"]) {
////#ifdef DEBUG
////    LEANPLUM_USE_ADVERTISING_ID;
////    [Leanplum setAppId:keys[@"leanplum"][@"app_id_dev"]
////    withDevelopmentKey:keys[@"leanplum"][@"app_key_dev"]];
////#else
////    [Leanplum setAppId:keys[@"leanplum"][@"app_id_prod"]
////     withProductionKey:keys[@"leanplum"][@"app_key_prod"];
////#endif
////     [Leanplum trackInAppPurchases];
////     [Leanplum trackAllAppScreens];
////     [Leanplum start];
//  }
//}
//
//+ (void)setupUserId:(NSString *)userid
//{
//  [[Mixpanel sharedInstance] identify:userid];
//  [[Amplitude instance] setUserId:userid];
////  [Leanplum setUserId:userid];
//}
//+ (void)setupUserProperties:(NSDictionary *)properties
//{
//  [[Mixpanel sharedInstance].people set:properties];
//  [[Amplitude instance] setUserProperties:properties];
////  [Leanplum setUserAttributes:properties];
//}
//
//+ (void)incrementUserProperties:(NSDictionary *)properties
//{
//  [[Mixpanel sharedInstance].people increment:properties];
////  [Amplitude instance]
////  [Leanplum]
//}
//
//+ (void)trackCharge:(NSNumber *)charge
//{
//  [[Amplitude instance] logRevenue:charge];
////  [[Mixpanel sharedInstance] trackCharge:charge];
//}
//
//
//+ (void)track:(NSString *)event
//{
//  [[Mixpanel sharedInstance] track:event];
//  [[Amplitude instance] logEvent:event];
////  [Leanplum track:event];
//}
//
//+ (void)track:(NSString *)event properties:(NSDictionary *)properties
//{
//  [[Mixpanel sharedInstance] track:event properties:properties];
//  [[Amplitude instance] logEvent:event withEventProperties:properties];
////  [Leanplum track:event withParameters:properties];
//}
//
//@end
