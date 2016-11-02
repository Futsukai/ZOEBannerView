//
//  ZOECollectionViewCell.m
//  ZOECycleView
//
//  Created by 疯兔 on 15/5/11.
//  Copyright (c) 2015年 Mr.z. All rights reserved.
//

#import "ZOECollectionViewCell.h"
@implementation ZOECollectionViewCell{
    UIImageView *_imageView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview: _imageView];
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    [_imageView setImage:image];
}
-(void)loadImageForURLString:(NSString *)urlString andPlaceholdImage:(UIImage *)placeholdImage
{
    if (_imageView.image == nil) {
        [self setImage:placeholdImage];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setImage:image];
                });
            }
        }
    }];
    [dataTask resume];
}
@end
