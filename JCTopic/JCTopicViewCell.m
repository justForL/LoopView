//
//  JCTopicViewCell.m
//  JCTopic
//
//  Created by James on 16/6/29.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "JCTopicViewCell.h"

@implementation JCTopicViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSelf];
    }
    return self;
}
#pragma mark - initail
- (instancetype)init {
    if (self = [super init]) {
        [self setupSelf];
    }
    return self;
}

- (void)setupSelf {
    self.imageView = [[UIImageView alloc]init];
    self.imageView.image = [UIImage imageNamed:@"indexBackgroundImg01"];
    [self.contentView addSubview:self.imageView];
    self.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
#pragma mark - lazyLoad
+ (instancetype)creatCellWithCollection:(UICollectionView *)collectionView WithID:(NSString *)ID withIndexPath:(NSIndexPath *)indexPath{
    
    JCTopicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}
@end
