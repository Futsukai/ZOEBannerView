//
//  ZOEPageControl.h
//  NewImageClass
//
//  Created by 疯兔 on 15/6/1.
//  Copyright (c) 2015年 ZW. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, pagerShape){
    pagerShapeRound  = 0,
    pagerShapeSquare = 1
};
@interface ZOEPageControl : UIPageControl
/**
 *  指示器形状，默认round
 */
@property(nonatomic,assign)pagerShape pageControlSubViewShape;
/**
 *  指示器大小,pagerShapeSquare模式下有效,默认50，10
 */
@property(nonatomic,assign)CGSize pageControlSubViewCGSize;
/**
 *  间距，默认为0
 */
@property(nonatomic,assign)CGFloat pageSpace;
@end
