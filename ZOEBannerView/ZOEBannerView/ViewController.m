//
//  ViewController.m
//  ZOEBannerView
//
//  Created by zhangwei on 2016/11/2.
//  Copyright © 2016年 Mr.Z. All rights reserved.
//

#import "ViewController.h"
#import "ZOEBannerView.h"

@interface ViewController ()

@end

@implementation ViewController{
    ZOEBannerView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    view = [ZOEBannerView ZOEBannerViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 350) placeholderImage:[UIImage imageNamed:@"placeholderImage"] withCycleTimes:3 selectAtCell:^(NSInteger selectNumber) {
        NSLog(@"%tu",selectNumber);
    }];
//    NSArray *imgAry = @[@"https://qiushibao-img.oss-cn-beijing.aliyuncs.com/4c6e10ce58fa96ac2ccdc3c742fc22e6",
//                        @"https://qiushibao-img.oss-cn-beijing.aliyuncs.com/e48cf641314c8c379d3f444e0fdecedc",
//                        @"https://qiushibao-img.oss-cn-beijing.aliyuncs.com/84c7818bb8550bf7007e6a25be7dc2b3"];
    NSArray *imgAry = @[@"https://qiushibao-img.oss-cn-beijing.aliyuncs.com/4c6e10ce58fa96ac2ccdc3c742fc22e6"];
    [self.view addSubview: view];
//    [view setImageGroup:imgAry];
    [view setCurrentPageColor:[UIColor redColor]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *imgAry = @[@"https://qiushibao-img.oss-cn-beijing.aliyuncs.com/4c6e10ce58fa96ac2ccdc3c742fc22e6",
                        @"https://qiushibao-img.oss-cn-beijing.aliyuncs.com/e48cf641314c8c379d3f444e0fdecedc",
                        @"https://qiushibao-img.oss-cn-beijing.aliyuncs.com/84c7818bb8550bf7007e6a25be7dc2b3"];
    [view setImageGroup:imgAry];
    [view setCurrentPageColor:[UIColor yellowColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
