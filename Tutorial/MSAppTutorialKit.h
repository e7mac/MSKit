//
//  MSAppTutorialKit.h
//  Pods
//
//  Created by Mayank on 8/28/15.
//
//

#import <Foundation/Foundation.h>

@interface MSAppTutorialKit : NSObject

+(void)setupWithToken:(NSString *)token;
+(void)showOnboardingOnce:(BOOL)once;
+(void)showOnboarding;

@end
