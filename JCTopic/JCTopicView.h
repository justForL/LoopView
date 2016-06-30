//
//  ImageView.h
//  JCTopic
//
//  Created by ghy on 16/6/29.
//  Copyright © 2016年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCTopicView;
@protocol ImageViewDelegate <NSObject>

- (void)didClickImageWithIndex:(NSInteger)index imageUrl:(NSString *)url;

@end
@interface JCTopicView : UIView
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, assign) id<ImageViewDelegate> delegate;

@end
