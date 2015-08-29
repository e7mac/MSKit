//
//  MSAppTutorialViewController.m
//  GrainProc
//
//  Created by Mayank on 8/28/15.
//  Copyright (c) 2015 Mayank, Kurt. All rights reserved.
//

#import "MSAppTutorialViewController.h"
//#import "MSTutorialPageViewController.h"
#import "MSTutorialTitleImageTextPageViewController.h"
#import "MSTutorialTitleFullImageTextPageViewController.h"
//#import <UIImageView+AFNetworking.h>
//#import "TPURLManager.h"

@interface MSAppTutorialViewController ()

@end

@implementation MSAppTutorialViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(NSArray *)defaultPages
{
  return @[
           @{
             @"type" : @"MSTutorialTitleFullImageTextPageViewController",
             @"image":@{
                 @"type" : @"UIImageView",
                 @"name" : @"challenge_mode",
                 },
             @"text" : @"Brighten your brain with Cognito's daily\ntraining games, scientifically designed to\nwork your memory, focus, and more.",
             @"title" : @"Social Play",
             },
           @{
             @"type" : @"MSTutorialTitleFullImageTextPageViewController",
             @"image":@{
                 @"type" : @"UIImageView",
                 @"name" : @"games",
                 },
             @"text" : @"Cognitive training is more fun together. Play\nwith your friends in\nbrain-to-brain challenges.",
             @"button" : @{
                 @"title": @"Enable Social Play",
                 @"action": @"askForPushPermissions",
                 },
             },
           @{
             @"type" : @"MSTutorialTitleFullImageTextPageViewController",
             @"image":@{
                 @"type" : @"UIImageView",
                 @"name" : @"insights",
                 },
             @"text" : @"Get personalized insights about each\ncognitive skill, and see how they interact\nwith your daily activity and sleep.",
             },
           @{
             @"type" : @"MSTutorialTitleFullImageTextPageViewController",
             @"image":@{
                 @"type" : @"UIImageView",
                 @"name" : @"travel",
                 },
             @"text" : @"Get personalized insights about each\ncognitive skill, and see how they interact\nwith your daily activity and sleep.",
             @"button" : @{
                 @"action":@"dismiss",
                 @"title":@"Ok",
                 },
             },
           
           ];
}

-(NSArray *)pickPagesForTutorial
{
  NSArray *pages;
  self.tutorialName = @"default";
//  NSString *source = [TPURLManager sharedInstance].source;
  NSString *source = nil;
  if (self.tutorialSpecs) {
    if ([self.tutorialSpecs objectForKey:source]) {
      self.tutorialName = source;
    } else {
      NSMutableDictionary *specs = [self.tutorialSpecs mutableCopy];
      [specs removeObjectsForKeys:@[@"default", @"challenge", @"promo", @"referral"]];
      NSArray *tests = [specs allKeys];
      if (tests.count > 0) {
        int testNumber = arc4random_uniform((unsigned int)tests.count)%(tests.count);
        self.tutorialName = tests[testNumber];
      }
    }
    pages = self.tutorialSpecs[self.tutorialName];
  } else {
    pages = [self defaultPages];
    self.tutorialName = @"appDefault";
  }
  return pages;
}

-(void)preparePages
{
  NSArray *pages = [self pickPagesForTutorial];
  NSMutableArray *pageVCs = [@[] mutableCopy];
  for (NSDictionary *page in pages) {
    UIViewController *pageVC;
    if ([page[@"type"] isEqualToString:@"TPLogin"]) {
//      pageVC = [[UIStoryboard storyboardWithName:@"TPLogin" bundle:nil] instantiateInitialViewController];
    } else if ([page[@"type"] isEqualToString:@"MSTutorialTitleImageTextPageViewController"]
               || [page[@"type"] isEqualToString:@"MSTutorialTitleFullImageTextPageViewController"]) {
      Class TutorialClass = NSClassFromString(page[@"type"]);
      MSTutorialTitleImageTextPageViewController *textImageVC = [[TutorialClass alloc] init];
      textImageVC.view.frame = self.view.bounds;
      textImageVC.titleLabel.text = page[@"title"];
      textImageVC.detailLabel.text = page[@"text"];
      textImageVC.button.hidden = YES;
      if ([page objectForKey:@"button"] && [self respondsToSelector:NSSelectorFromString(page[@"button"][@"action"])]) {
        textImageVC.button.hidden = NO;
        [textImageVC.button setTitle:page[@"button"][@"title"] forState:UIControlStateNormal];
        [textImageVC.button addTarget:self action:NSSelectorFromString(page[@"button"][@"action"]) forControlEvents:UIControlEventTouchUpInside];
      }

      pageVC = textImageVC;
      if ([page[@"image"][@"type"] isEqualToString:@"UIImageView"]) {
        NSString *imageName = page[@"image"][@"name"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
          NSString *iPadImageName = [NSString stringWithFormat:@"%@_ipad", imageName];
          if ([UIImage imageNamed:iPadImageName]) {
            imageName = iPadImageName;
          }
        }
        UIImage *image = [UIImage imageNamed:imageName];
        NSURL *url = [NSURL URLWithString:page[@"image"][@"name"]];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = [UIScreen mainScreen].bounds;// textImageVC.graphicView.bounds;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [textImageVC.graphicView addSubview:imageView];
//        [imageView setImageWithURL:url placeholderImage:image];
      } else if ([page[@"image"][@"type"] isEqualToString:@"AnimatedView"]) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:page[@"image"][@"name"]
                                                         owner:self
                                                       options:nil];
        for (id object in objects) {
          if ([object isKindOfClass:[NSClassFromString(page[@"image"][@"name"]) class]]) {
            UIView *view = (UIView *)object;
            view.frame = textImageVC.graphicView.bounds;
            [textImageVC.graphicView addSubview:view];
            break;
          }
        }
      }
    }
    pageVC.view.frame = self.view.bounds;
    [pageVCs addObject:pageVC];
  }
  
  self.pageVCs = pageVCs;
  
  if (self.pageVCs.count > 0) {
    [self setViewControllers:@[[self.pageVCs firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [[self.pageVCs firstObject] animate];
  }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
  [super pageViewController:pageViewController didFinishAnimating:finished previousViewControllers:previousViewControllers transitionCompleted:completed];
//  self.pageControl.hidden = [[pageViewController.viewControllers firstObject] isKindOfClass:[TPNavigationController class]];
}

-(BOOL)prefersStatusBarHidden
{
  return YES;
}

-(void)dismiss
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end