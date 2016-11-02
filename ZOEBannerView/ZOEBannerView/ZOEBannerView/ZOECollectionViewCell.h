//
//  ZOECollectionViewCell.h
//  ZOECycleView
//
//  Created by 疯兔 on 15/5/11.
//  Copyright (c) 2015年 Mr.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZOECollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImage *image;
-(void)loadImageForURLString:(NSString *)urlString andPlaceholdImage:(UIImage *)placeholdImage;
@end
