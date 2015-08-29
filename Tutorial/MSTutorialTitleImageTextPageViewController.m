//
//  MSTutorialTitleImageTextPageViewController.m
//  GrainProc
//
//  Created by Mayank on 8/28/15.
//  Copyright (c) 2015 Mayank, Kurt. All rights reserved.
//

#import "MSTutorialTitleImageTextPageViewController.h"

@interface MSTutorialTitleImageTextPageViewController ()

@end

@implementation MSTutorialTitleImageTextPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animate
{
  // TODO - iOS7 tutorial animation bug (temporary fix where animations are turned off for IOS7)
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    for (id view in self.graphicView.subviews) {
      if ([view respondsToSelector:@selector(animate)]) {
        [view animate];
      }
    }
  } else {
    for (id view in self.graphicView.subviews) {
      if ([view respondsToSelector:@selector(animate)]) {
        //        [view unhide];
      }
    }
  }
}

@end
