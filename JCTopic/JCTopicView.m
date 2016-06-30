//
//  ImageView.m
//  JCTopic
//
//  Created by ghy on 16/6/29.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "JCTopicView.h"
#import "FlowLayout.h"
#import "JCTopicViewCell.h"
#import "UIImageView+WebCache.h"

static NSString *itemID = @"itemID";
@interface JCTopicView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation JCTopicView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.imageView.frame = self.bounds;
}

- (void)displayLinkAction {
    
    if (self.pics.count > 0) {
        NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
        
        NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:3/2];
        [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        NSInteger nextItem = currentIndexPathReset.item +1;
        NSInteger nextSection = currentIndexPathReset.section;
        if (nextItem==self.pics.count) {
            nextItem=0;
            nextSection++;
        }
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        self.pageControl.currentPage = nextIndexPath.item;
    }
    
}

- (instancetype)init {
    if (self = [super init]) {
        self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"indexBackgroundImg01"]];
        [self addSubview:self.imageView];
        self.imageView.frame = self.bounds;
        [self addSubview:self.collectionView];
        [_collectionView registerClass:[JCTopicViewCell class] forCellWithReuseIdentifier:itemID];

                [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
    }
    return self;
}
#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pics.count ;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JCTopicViewCell *cell = [JCTopicViewCell creatCellWithCollection:collectionView WithID:itemID withIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.pics[indexPath.row]] placeholderImage:[UIImage imageNamed:@"indexBackgroundImg01"]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld",(long)indexPath.item);
    if ([self.delegate respondsToSelector:@selector(didClickImageWithIndex:imageUrl:)]) {
        [self.delegate didClickImageWithIndex:indexPath.item imageUrl:self.urls[indexPath.item]];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 1. 获取当前停止的页面
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = offset % self.pics.count;
    NSIndexPath *indexpath = nil;
    //最后一组最后一张
    if (offset % self.pics.count == self.pics.count -1) {
        indexpath = [NSIndexPath indexPathForItem:self.pics.count - 1 inSection:0];
    }
    //第一张
    if (offset % self.pics.count == 0) {
        indexpath = [NSIndexPath indexPathForItem:0 inSection:1];
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.displayLink setPaused:YES];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.displayLink.isPaused) {
        [self.displayLink setPaused:NO];
    }
}
#pragma pics Setter
- (void)setPics:(NSArray *)pics {
    _pics = pics;
    self.pageControl.numberOfPages = pics.count;
    [self.collectionView reloadData];
    
    
    [self addSubview:self.pageControl];
    self.pageControl.center = CGPointMake(self.center.x, self.bounds.size.height-10);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
        
        // 滚动位置！
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    });
}
#pragma mark - lazy load
-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        FlowLayout *flowLayout = [[FlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}
-(CADisplayLink *)displayLink {
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];

        _displayLink.frameInterval = 60 * 5;
    }
    return _displayLink;
}
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
    }
    return _pageControl;
}
@end
