//
//  MSTutorialViewController.m
//  GrainProc
//
//  Created by Mayank on 8/28/15.
//  Copyright (c) 2015 Mayank, Kurt. All rights reserved.
//

#import "MSTutorialViewController.h"

@interface MSTutorialViewController ()
{
  int _currentIndex;
}

@end

@implementation MSTutorialViewController

-(instancetype)init
{
  self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
  if (self) {
  }
  return self;
}

-(NSString *)tutorialName
{
  if (!_tutorialName) _tutorialName = @"";
  return _tutorialName;
}

- (NSArray *)pageVCs
{
  if (_pageVCs == nil) {
    _pageVCs = [[NSArray alloc] init];
  }
  return _pageVCs;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.delegate = self;
  self.dataSource = self;
  _currentIndex = 0;
  [self preparePages];
  self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
  self.pageControl.numberOfPages = self.pageVCs.count;
  self.pageControl.currentPage = 0;
  self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:1];
  self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.25];
  
  [self.view addSubview:self.pageControl];
  
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.pageControl.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height - 15);
}

-(void)preparePages
{
  
}

-(void)done
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
  NSUInteger index = [self.pageVCs indexOfObject:viewController];
  if (index == 0) return nil;
  index--;
  NSString *event = [NSString stringWithFormat:@"%@ shown", NSStringFromClass([self class])];
//  [MSAnalytics track:@"Tutorial Page shown" properties:@{
//                                                         @"page":@(index),
//                                                         @"class" : NSStringFromClass([self class]),
//                                                         @"name": self.tutorialName,
//                                                         }];
  return self.pageVCs[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
  NSUInteger index = [self.pageVCs indexOfObject:viewController];
  if (index == self.pageVCs.count - 1) return nil;
  index++;
  NSString *event = [NSString stringWithFormat:@"%@ shown", NSStringFromClass([self class])];
//  [MSAnalytics track:event properties:@{@"page":@(index)}];
  return self.pageVCs[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
  id viewController = pageViewController.viewControllers[0];
  // TODO: good design for the purpose below?
  if ([viewController respondsToSelector:@selector(animate)]) {
    [viewController performSelector:@selector(animate)];
  }
  NSUInteger index = [self.pageVCs indexOfObject:viewController];
  [self.pageControl setCurrentPage:index];
}


@end