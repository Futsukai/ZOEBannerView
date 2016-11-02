//
//  ZOEBannerView.m
//  ZOEBannerView
//
//  Created by zhangwei on 2016/11/2.
//  Copyright © 2016年 Mr.Z. All rights reserved.
//

#import "ZOEBannerView.h"
#import "ZOECollectionViewCell.h"

NSString *const bannerCellID = @"ZOEBannerCellID";
@implementation ZOEBannerView{
    UICollectionView *_mainCollectionView;
    UICollectionViewFlowLayout *_layout;
    selectItemBlock _selectItemBlock;
    UIImage *_placeHoldImage;
    ZOEPageControl *_pageControl;
    NSTimeInterval _timeInterval;
    dispatch_source_t _timer;
    NSInteger _currentIndex;
    
    BOOL _dispathIsSuspend;
}
+(instancetype)ZOEBannerViewWithFrame:(CGRect)rect placeholderImage:(UIImage *)placeholdImage withCycleTimes:(NSTimeInterval)times selectAtCell:(selectItemBlock)callBack
{
    return [[ZOEBannerView alloc]initWithFrame:rect withPlaceHoldImage:placeholdImage withCycleTimes:times selectAtCell:callBack];
}
-(instancetype)initWithFrame:(CGRect)frame withPlaceHoldImage:(UIImage *)placeholdImage withCycleTimes:(NSTimeInterval)times selectAtCell:(selectItemBlock)callBack
{
    if (self = [super initWithFrame:frame]) {
        NSAssert(placeholdImage != nil, @"placeholdImage must have one");
        _selectItemBlock = [callBack copy];
        _placeHoldImage = placeholdImage;
        _layout = [[UICollectionViewFlowLayout alloc]init];
        [_layout setMinimumInteritemSpacing:0];
        [_layout setMinimumLineSpacing:0];
        [_layout setItemSize:self.bounds.size];
        [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
        [_mainCollectionView  registerClass:[ZOECollectionViewCell class] forCellWithReuseIdentifier:bannerCellID];
        [_mainCollectionView setDelegate:(id<UICollectionViewDelegate> _Nullable)self];
        [_mainCollectionView setDataSource:(id<UICollectionViewDataSource> _Nullable)self];
        [_mainCollectionView setPagingEnabled:YES];
        [_mainCollectionView setShowsHorizontalScrollIndicator:NO];
        [_mainCollectionView setShowsVerticalScrollIndicator:NO];
        [_mainCollectionView setBackgroundColor:[UIColor clearColor]];
        [self addSubview: _mainCollectionView];
        _currentIndex = 0;
        _timeInterval = times;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_imageGroup.count > 1) {
        return 3;
    }
    return _imageGroup.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZOECollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerCellID forIndexPath:indexPath];
    NSInteger index = (_currentIndex + indexPath.item - 1 + self.imageGroup.count) % self.imageGroup.count;
    id temp =self.imageGroup[index];
    if ([temp isKindOfClass:[UIImage class]]) {
        [cell setImage: temp];
    }else{
        [cell loadImageForURLString:temp andPlaceholdImage:_placeHoldImage];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectItemBlock) {
        _selectItemBlock(_currentIndex);
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self upDataForScrollViewDidEndScroll:scrollView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _timer = nil;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
 
    [self upDataForScrollViewDidEndScroll:scrollView];
    [self dispatchSetUp];
}
#pragma mark - AutoCycle
-(void)setImageGroup:(NSArray *)imageGroup
{
    _currentIndex = 0;
    _imageGroup = imageGroup;
    _timer = nil;
    [self ZOEp_upPageControl];
    [_mainCollectionView reloadData];
    if (_imageGroup.count > 1) {
        [self dispatchSetUp];
        [_mainCollectionView setScrollEnabled:YES];
        NSIndexPath *myindexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [_mainCollectionView scrollToItemAtIndexPath:myindexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else{
        [_mainCollectionView setScrollEnabled:NO];
    }
}
-(void)dispatchSetUp
{
    if (_timeInterval < 0.5) {
        return;
    }
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeInterval * NSEC_PER_SEC)), _timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self nextImage];
        });
    });
    dispatch_resume(timer);
    _timer = timer;
}
-(void)upDataForScrollViewDidEndScroll:(UIScrollView *)scrollView
{
    if (self.imageGroup.count < 1) {
        return;
    }
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _currentIndex = (_currentIndex + page - 1 + self.imageGroup.count) % self.imageGroup.count;
    NSIndexPath *myindexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [_mainCollectionView reloadItemsAtIndexPaths:@[myindexPath]];
    [_mainCollectionView scrollToItemAtIndexPath:myindexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [_pageControl setCurrentPage:_currentIndex];
}
-(void)nextImage
{
    NSInteger direction;
    switch (self.scrollDirection) {
        case CycleScrollDirectionLeft:
            direction = 0;
            break;
        default:
            direction = 2;
            break;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:direction inSection:0];
    [_mainCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}
#pragma mark - 设置指示器数据
-(void)ZOEp_upPageControl
{
    if (!_pageColor) {
        _pageColor = [UIColor lightGrayColor];
    }
    if (!_currentPageColor) {
        _currentPageColor = [UIColor whiteColor];
    }
    [_pageControl removeFromSuperview];
    _pageControl = [[ZOEPageControl alloc]initWithFrame:self.bounds];
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    [_pageControl setCurrentPageIndicatorTintColor:_currentPageColor];
    [_pageControl setNumberOfPages:self.imageGroup.count];
    [_pageControl setPageIndicatorTintColor:_pageColor];
    [_pageControl setHidden:YES];
    [self addSubview: _pageControl];
}
-(void)setCurrentPageColor:(UIColor *)currentPageColor
{
    _currentPageColor = currentPageColor;
    [_pageControl setCurrentPageIndicatorTintColor:_currentPageColor];
    [_pageControl setHidden:NO];
}
-(void)setPageColor:(UIColor *)pageColor
{
    _pageColor = pageColor;
    [_pageControl setPageIndicatorTintColor:_pageColor];
    [_pageControl setHidden:NO];
}

-(CycleScrollDirection)scrollDirection
{
    if (_scrollDirection != CycleScrollDirectionLeft && _scrollDirection != CycleScrollDirectionRight) {
        _scrollDirection = CycleScrollDirectionRight;
    }
    return _scrollDirection;
}
@end











