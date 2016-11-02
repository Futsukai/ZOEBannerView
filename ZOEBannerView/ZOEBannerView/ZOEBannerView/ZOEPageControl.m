//
//  ZOEPageControl.m
//  NewImageClass
//
//  Created by 疯兔 on 15/6/1.
//  Copyright (c) 2015年 ZW. All rights reserved.
//

#import "ZOEPageControl.h"
@interface ZOEPageControl()
@end
@implementation ZOEPageControl
-(void)drawRect:(CGRect)rect
{
    [self setUserInteractionEnabled:NO];
    CGFloat pageM = self.pageSpace;
    CGFloat pageX = (self.bounds.size.width - (self.numberOfPages - 1) *pageM - self.pageControlSubViewCGSize.width * self.numberOfPages) / 2;
    CGFloat pageY = self.bounds.size.height - self.pageControlSubViewCGSize.height - 5;
    CGFloat pageW = self.pageControlSubViewCGSize.width;
    for (int i = 0; i < self.numberOfPages; i++) {
        UIView * view = [self.subviews objectAtIndex: i];
        if (self.pageControlSubViewShape) {
            [view.layer setCornerRadius: 0];
            [view.layer setMasksToBounds:YES];
            CGFloat currertPageX = pageX + i * (pageW + pageM);
            [view setFrame:CGRectMake( currertPageX, pageY, pageW,self.pageControlSubViewCGSize.height)];
        }else{
            pageX = view.frame.origin.x;
            pageY = view.frame.origin.y * 1.9;
            [view setFrame:CGRectMake(pageX, pageY, 7, 7)];
        }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}
#pragma mark - 处理间距
-(CGFloat)pageSpace
{
    if (_pageSpace >= self.bounds.size.width / self.numberOfPages) {
        return 1;
    }else if (_pageSpace <= 0)  return 10;
    return _pageSpace;
}
-(CGSize)pageControlSubViewCGSize
{
    if (_pageControlSubViewCGSize.width <= 0 || _pageControlSubViewCGSize.height <= 0) {
        CGSize size = CGSizeMake(50.0, 10.0);
        return size;
    }
    return _pageControlSubViewCGSize;
}

@end
