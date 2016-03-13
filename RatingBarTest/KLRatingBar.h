//
//  KLRatingBar.h
//  RatingBarTest
//
//  Created by xiangkai yin on 16/3/11.
//  Copyright © 2016年 kuailao_2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StarChangedBlock)(NSInteger number);

@interface KLRatingBar : UIView

/**
 *  是否允许触摸
 */
@property (nonatomic) BOOL enbale;

/**
 *  星的个数
 */
@property (nonatomic) NSInteger starCount;

/**
 *  修改背景
 */
@property (nonatomic,strong) UIColor *cColor;

/**
 *  选择评分回调
 */
@property (nonatomic,copy) StarChangedBlock starChoiceBlock;

@end
