//
//  ViewController.m
//  JCTopic
//
//  Created by ghy on 16/6/29.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "ViewController.h"
#import "JCTopicView.h"
#import "JCTopicViewCell.h"
#import "KYNetWorking.h"

@interface ViewController ()<ImageViewDelegate>
@property (nonatomic, strong) JCTopicView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //http://www.tripg.cn/phone_api/index_img_carousel.php?project_id=14
    [self setupImageView];
    [self loadHttpData];
    
}

- (void)setupImageView {
    JCTopicView *imageView = [[JCTopicView alloc]init];
    self.imageView = imageView;
    imageView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 130);
    self.imageView.delegate = self;
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
//    imageView.pics = @[@"1",@"2",@"3"];
}

-(void)didClickImageWithIndex:(NSInteger)index imageUrl:(NSString *)url {
    NSLog(@"索引:%zd----URL:%@",index,url);
}
- (void)loadHttpData {
    NSString *url = @"http://www.tripg.cn/phone_api/index_img_carousel.php?project_id=14";

    [[KYNetWorking sharedNetWorking] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *code = [responseObject objectForKey:@"Code"];
        if ([code isEqualToString:@"1"]) {
            NSArray *Result = [responseObject objectForKeyedSubscript:@"Result"];
            NSMutableArray *urlArray = [NSMutableArray array];
            NSMutableArray *picArray = [NSMutableArray array];
            for (NSDictionary *dict in Result) {
                [urlArray addObject:[dict valueForKey:@"url"]];
                [picArray addObject:[dict valueForKey:@"imgRoute"]];
            }
            self.imageView.pics = picArray;
            self.imageView.urls = urlArray;
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
