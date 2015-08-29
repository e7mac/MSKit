//
//  MSAppTutorialKit.m
//  Pods
//
//  Created by Mayank on 8/28/15.
//
//

#import "MSAppTutorialKit.h"
#import "MSAppTutorialViewController.h"
#import "MSConfigService.h"
#import <UIKit/UIKit.h>

@interface MSAppTutorialKit()

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *bundleId;

@end

@implementation MSAppTutorialKit

+ (instancetype)sharedInstance
{
  static MSAppTutorialKit *sharedInstance = nil;
  if (sharedInstance == nil)
  {
    sharedInstance = [(MSAppTutorialKit *)[self alloc] init];
  }
  return sharedInstance;
}

+(void)setupWithToken:(NSString *)token
{
  MSAppTutorialKit *kit = [self sharedInstance];
  kit.token = token;
  kit.bundleId = [NSBundle mainBundle].bundleIdentifier;
}

-(NSString *)specsPath
{
  return [NSString stringWithFormat:@"%@_%@.json", self.token, self.bundleId];
}

+(void)showOnboardingOnce:(BOOL)once
{
  BOOL show = YES;
  if (once) {
    NSString *key = @"MSAppTutorialShown";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:key]) {
      show = NO;
    } else {
      [defaults setBool:YES forKey:key];
    }
  }
  if (show) {
    [self showOnboarding];
  }
}

+(void)showOnboarding
{
  MSAppTutorialViewController *vc = [[MSAppTutorialViewController alloc] init];
    [MSConfigService fetchResourceAtPath:[[self sharedInstance] specsPath] success:^(id responseObject) {
      vc.tutorialSpecs = responseObject;
      [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    } failure:^(NSError *error) {
      [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    }];
}

@end
