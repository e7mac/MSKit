//
//  MSAppTutorialViewController.m
//  GrainProc
//
//  Created by Mayank on 8/28/15.
//  Copyright (c) 2015 Mayank, Kurt. All rights reserved.
//

#import "MSAppTutorialViewController.h"
#import "MSTutorialTitleImageTextPageViewController.h"
#import "MSTutorialTitleFullImageTextPageViewController.h"
#import <UIImageView+AFNetworking.h>
#import <TSMarkdownParser.h>
#import "PureLayout.h"

#define THIN_BAR_HEIGHT 44
#define LOGIN_SECTION_HEIGHT 150

@interface MSAppTutorialViewController ()

@property (nonatomic, strong) TSMarkdownParser *titleParser;
@property (nonatomic, strong) TSMarkdownParser *detailParser;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation MSAppTutorialViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
  self.footerView = [self loginView];
  
  [self.pageControl autoAlignAxisToSuperviewAxis:ALAxisVertical];
  [self.pageControl autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.footerView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(NSDictionary *)defaultSpec
{
  return @{
           @"font":@{
               @"title":@{
                   @"regular":@"AvenirNext-Bold",
                   @"bold":@"AvenirNext-DemiBold",
                   @"italic":@"AvenirNext-Italic",
                   @"size": @20,
                   },
               @"detail":@{
                   @"regular":@"Futura-Medium",
                   @"bold":@"Futura-CondensedExtraBold",
                   @"italic":@"Futura-MediumItalic",
                   @"size": @15
                   }
               },
           @"pages":@[
               @{
                 @"type" : @"MSTutorialTitleFullImageTextPageViewController",
                 @"image":@{
                     @"type" : @"UIImageView",
                     @"name" : @"challenge_mode",
                     },
                 @"text" : @"*Brighten* your brain with **Cognito's** daily\ntraining games, scientifically designed to\nwork your memory, focus, and more.",
                 @"title" : @"*Social* Play",
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
               ]
           };
}

-(NSDictionary *)pickSpec
{
  NSDictionary *spec;
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
    spec = self.tutorialSpecs[self.tutorialName];
  } else {
    spec = [self defaultSpec];
    self.tutorialName = @"appDefault";
  }
  return spec;
}

-(void)customizeLooksWithFontDictionary:(NSDictionary *)fonts
{
  CGFloat titleSize = [fonts[@"title"][@"size"] floatValue];
  CGFloat detailSize = [fonts[@"detail"][@"size"] floatValue];
  
  UIFont *titleFont = [UIFont fontWithName:fonts[@"title"][@"regular"] size:titleSize];
  UIFont *titleBoldFont = [UIFont fontWithName:fonts[@"title"][@"bold"] size:titleSize];
  UIFont *titleItalicFont = [UIFont fontWithName:fonts[@"title"][@"italic"] size:titleSize];
  
  UIFont *detailFont = [UIFont fontWithName:fonts[@"detail"][@"regular"] size:detailSize];
  UIFont *detailBoldFont = [UIFont fontWithName:fonts[@"detail"][@"bold"] size:detailSize];
  UIFont *detailItalicFont = [UIFont fontWithName:fonts[@"detail"][@"italic"] size:detailSize];
  
  self.titleParser = [TSMarkdownParser standardParser];
  
  self.titleParser.paragraphFont = titleFont;
  self.titleParser.strongFont = titleBoldFont;
  self.titleParser.emphasisFont = titleItalicFont;
  
  self.detailParser = [TSMarkdownParser standardParser];
  
  self.detailParser.paragraphFont = detailFont;
  self.detailParser.strongFont = detailBoldFont;
  self.detailParser.emphasisFont = detailItalicFont;
}

-(void)preparePages
{
  UIFont *titleFont = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:35];
  UIFont *detailFont = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:20];
  
  NSDictionary *spec = [self pickSpec];
  
  NSArray *pages = spec[@"pages"];
  [self customizeLooksWithFontDictionary:spec[@"font"]];
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
      if ([page objectForKey:@"backgroundColor"]) {
        textImageVC.view.backgroundColor = [self colorFromHexString:page[@"backgroundColor"]];
      }
      textImageVC.titleLabel.font = titleFont;
      textImageVC.detailLabel.font = detailFont;
      if (page[@"title"]) {
        textImageVC.titleLabel.attributedText = [self.titleParser attributedStringFromMarkdown:page[@"title"]];
      }
      if (page[@"text"]) {
        textImageVC.detailLabel.attributedText = [self.detailParser attributedStringFromMarkdown:page[@"text"]];
      }
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
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [textImageVC.graphicView addSubview:imageView];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [imageView setImageWithURL:url placeholderImage:image];
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
}

-(BOOL)prefersStatusBarHidden
{
  return YES;
}

-(void)dismiss
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
  unsigned rgbValue = 0;
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(void)setHeaderView:(UIView *)v
{
  if (!v) [_footerView removeFromSuperview];
  _headerView = v;
  if (v) {
    [self.view addSubview:v];
    [v autoSetDimension:ALDimensionHeight toSize:v.bounds.size.height];
    [v autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [v autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [v autoPinEdgeToSuperviewEdge:ALEdgeTop];
  }
}

-(void)setFooterView:(UIView *)v
{
  if (!v) [_footerView removeFromSuperview];
  _footerView = v;
  if (v) {
    [self.view addSubview:v];
    [v autoSetDimension:ALDimensionHeight toSize:v.bounds.size.height];
    [v autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [v autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [v autoPinEdgeToSuperviewEdge:ALEdgeBottom];
  }
}

-(UIView *)loginView
{
  CGFloat footerHeight = LOGIN_SECTION_HEIGHT;
  CGFloat buttonHeight = 50;
  UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, footerHeight)];
  v.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
  UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, buttonHeight)];
  [login setTitle:@"Login" forState:UIControlStateNormal];
  [v addSubview:login];
  [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
  [login autoAlignAxisToSuperviewAxis:ALAxisVertical];
  [login autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
  
  UIButton *facebook = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 500, buttonHeight)];
  [facebook setTitle:@"Facebook" forState:UIControlStateNormal];
  [v addSubview:facebook];
  [facebook addTarget:self action:@selector(facebook) forControlEvents:UIControlEventTouchUpInside];
  [facebook autoAlignAxisToSuperviewAxis:ALAxisVertical];
  [facebook autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:login];
  
  [self.view addSubview:v];
  return v;
}

-(UIView *)skipNextView
{
  CGFloat buttonPadding = 15;
  CGFloat footerHeight = THIN_BAR_HEIGHT;
  UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, footerHeight)];
  v.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
  [self.view addSubview:v];
  
  UIButton *login = [[UIButton alloc] init];
  [login setTitle:@"Skip" forState:UIControlStateNormal];
  [v addSubview:login];
  [login addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
  [login autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:buttonPadding];
  [login autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
  
  UIButton *facebook = [[UIButton alloc] init];
  [facebook setTitle:@"Next" forState:UIControlStateNormal];
  [v addSubview:facebook];
  [facebook addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchUpInside];
  [facebook autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:buttonPadding];
  [facebook autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
  
  return v;
}

-(UIView *)backForwardView
{
  CGFloat buttonPadding = 15;
  CGFloat footerHeight = THIN_BAR_HEIGHT;
  UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, footerHeight)];
  v.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
  [self.view addSubview:v];
  
  UIButton *login = [[UIButton alloc] init];
  [login setTitle:@"<" forState:UIControlStateNormal];
  [v addSubview:login];
  [login addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  [login autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:buttonPadding];
  [login autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
  
  UIButton *facebook = [[UIButton alloc] init];
  [facebook setTitle:@">" forState:UIControlStateNormal];
  [v addSubview:facebook];
  [facebook addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchUpInside];
  [facebook autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:buttonPadding];
  [facebook autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
  
  return v;
}

-(UIView *)singleActionFooterView
{
  CGFloat footerHeight = THIN_BAR_HEIGHT;
  UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, footerHeight)];
  v.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
  [self.view addSubview:v];
  
  UIButton *login = [[UIButton alloc] init];
  [login setTitle:@"ACTION" forState:UIControlStateNormal];
  [v addSubview:login];
  [login addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchUpInside];
  [login autoCenterInSuperview];
  
  return v;
}

#pragma mark Button Action

-(void)back
{
  UIViewController *currentVC = [self.viewControllers firstObject];
  unsigned long index = [self.pageVCs indexOfObject:currentVC];
  if (index > 0) {
    index--;
    [self setViewControllers:@[self.pageVCs[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    [[self.pageVCs firstObject] animate];
    self.pageControl.currentPage = index;
  }
}

-(void)forward
{
  UIViewController *currentVC = [self.viewControllers firstObject];
  unsigned long index = [self.pageVCs indexOfObject:currentVC];
  if (index < self.pageVCs.count - 1) {
    index++;
    [self setViewControllers:@[self.pageVCs[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [[self.pageVCs firstObject] animate];
    self.pageControl.currentPage = index;
  }
}

-(void)login
{
}

-(void)facebook
{
}
@end