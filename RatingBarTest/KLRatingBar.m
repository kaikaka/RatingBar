//
//  KLRatingBar.m
//  RatingBarTest
//
//  Created by xiangkai yin on 16/3/11.
//  Copyright © 2016年 kuailao_2. All rights reserved.
//

#import "KLRatingBar.h"

//缩放
static const CGFloat Zoom = 0.8;

@interface KLRatingBar()

/**
 *  底部 显示无星的视图
 */
@property (nonatomic, strong) UIView *ratingButtomView;

/**
 *  顶部 显示有星的视图
 */
@property (nonatomic, strong) UIView *ratingTopView;

/**
 *  星的宽度
 */
@property (nonatomic, assign) CGFloat starWidth;

@end

@implementation KLRatingBar

- (void)awakeFromNib {
  [super awakeFromNib];
  
  [self initialization];
}

- (id) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
    [self initialization];
  }
  return self;
}

- (void)initialization {
  self.backgroundColor = [UIColor whiteColor];
  
  self.ratingButtomView = [[UIView alloc] initWithFrame:self.bounds];
  self.ratingTopView = [[UIView alloc] initWithFrame:CGRectZero];
  
  [self addSubview:self.ratingButtomView];
  [self addSubview:self.ratingTopView];
  
  self.userInteractionEnabled = YES;
  //超出部分裁剪
  self.ratingTopView.clipsToBounds = YES;
  self.ratingButtomView.userInteractionEnabled = NO;
  self.ratingTopView.userInteractionEnabled = NO;
  
  UITapGestureRecognizer *topGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureTop:)];
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onGesturePan:)];
  [self addGestureRecognizer:topGesture];
  [self addGestureRecognizer:panGesture];
  
  //宽度 左间距 = 宽度 * 1.5
  CGFloat width = self.frame.size.width / 7.0;
  self.starWidth = width;
  
  for (int i = 0; i < 5; i++) {
    UIImageView *imgvNoStar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width * Zoom, width * Zoom)];
    imgvNoStar.center = CGPointMake((i+1.5) * width,self.frame.size.height /2);
    imgvNoStar.image = [UIImage imageNamed:@"bt_star_a"];
    //底部无星视图
    [self.ratingButtomView addSubview:imgvNoStar];
    
    UIImageView *imgvHaveStar = [[UIImageView alloc] initWithFrame:imgvNoStar.frame];
    imgvHaveStar.center = imgvNoStar.center;
    [imgvHaveStar setImage:[UIImage imageNamed:@"bt_star_b"]];
    [self.ratingTopView addSubview:imgvHaveStar];
  }
  self.enbale = YES;
}

- (void)setCColor:(UIColor *)color {
  if (_cColor != color) {
    self.backgroundColor = color;
    self.ratingButtomView.backgroundColor = color;
    self.ratingTopView.backgroundColor = color;
  }
}

- (void)setStarCount:(NSInteger)starCount {
  if (_starCount != starCount) {
    _starCount = starCount;
    self.ratingTopView.frame = CGRectMake(0, 0, self.starWidth * (starCount + 1), self.bounds.size.height);
  }
}

- (void)onGestureTop:(UITapGestureRecognizer *)recognizer {
  if (self.enbale) {
    //①获取坐标点
    CGPoint point = [recognizer locationInView:self];
    //②在星所在范围的值
    NSInteger count = (NSInteger)(point.x / self.starWidth)+1;
    //③减少或增加topview 的宽度  显示或覆盖buttom的view
    self.ratingTopView.frame = CGRectMake(0, 0, self.starWidth * count, self.bounds.size.height);
    if (count > 5) {
      _starCount = 5;
    } else {
      _starCount = count -1;
    }
    //④回调
    if (_starChoiceBlock) {
      _starChoiceBlock(_starCount);
    }
  }
}

- (void)onGesturePan:(UIPanGestureRecognizer *)recognizer {
  if (self.enbale) {
    CGPoint point = [recognizer locationInView:self];
    NSInteger count = (NSInteger)(point.x / self.starWidth);
    if (count >= 0 && count <= 5 && _starCount!= count) {
      self.ratingTopView.frame = CGRectMake(0, 0, self.starWidth * (count +1), self.bounds.size.height);
      _starCount = count;
      
      if (_starChoiceBlock) {
        _starChoiceBlock(_starCount);
      }
    }
  }
}

@end
