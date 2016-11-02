//
//  ZOEBannerView.h
//  ZOEBannerView
//
//  Created by zhangwei on 2016/11/2.
//  Copyright © 2016年 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOEPageControl.h"


typedef  void(^selectItemBlock)(NSInteger selectNumber);
typedef NS_ENUM(NSInteger, CycleScrollDirection){
    CycleScrollDirectionLeft  = 11,
    CycleScrollDirectionRight = 12
};
@interface ZOEBannerView : UIView
@property (nonatomic,strong)NSArray *imageGroup;
@property (nonatomic,assign)CycleScrollDirection scrollDirection;
+(instancetype)ZOEBannerViewWithFrame:(CGRect)rect placeholderImage:(UIImage *)placeholdImage withCycleTimes:(NSTimeInterval)times selectAtCell:(selectItemBlock)callBack;

-(instancetype)initWithFrame:(CGRect)frame withPlaceHoldImage:(UIImage *)placeholdImage withCycleTimes:(NSTimeInterval)times selectAtCell:(selectItemBlock)callBack;
#pragma mark - 指示器相关
/**
 *  指示器的颜色
 */
@property (nonatomic,strong)UIColor *pageColor;
/**
 *  当前指示器的高亮色
 */
@property (nonatomic,strong)UIColor *currentPageColor;
@end
