//
//  FlowLayout.m
//  JCTopic
//
//  Created by ghy on 16/6/29.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "FlowLayout.h"

@implementation FlowLayout

-(void)prepareLayout {
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}
@end
