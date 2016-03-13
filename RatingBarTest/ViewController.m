//
//  ViewController.m
//  RatingBarTest
//
//  Created by xiangkai yin on 16/3/11.
//  Copyright © 2016年 kuailao_2. All rights reserved.
//

#import "ViewController.h"
#import "KLRatingBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  KLRatingBar *bar = [[KLRatingBar alloc] initWithFrame:CGRectMake(0, 0, 180, 50)];
  [self.view addSubview:bar];
  bar.starChoiceBlock = ^ (NSInteger number) {
    NSLog(@"number = %ld",number);
  };
  bar.center = self.view.center;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
