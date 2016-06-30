//
//  JCTopicViewCell.h
//  JCTopic
//
//  Created by James on 16/6/29.
//  Copyright © 2016年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCTopicViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;

+ (instancetype)creatCellWithCollection:(UICollectionView *)collectionView WithID:(NSString *)ID withIndexPath:(NSIndexPath *)indexPath;
@end
