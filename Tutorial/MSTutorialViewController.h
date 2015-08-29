//
//  MSTutorialViewController.h
//  GrainProc
//
//  Created by Mayank on 8/28/15.
//  Copyright (c) 2015 Mayank, Kurt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTutorialViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

-(instancetype)init;

@property (nonatomic, strong) NSArray *pageVCs;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSString *tutorialName;

@end