//
//  SelectPicViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/12.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SelectPicViewController.h"
#import "ButtonCollectionViewCell.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface SelectPicViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy)NSMutableArray *dataArray;

@end

@implementation SelectPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化dataArray
    [self SetDataArray];
    
    //页面布局
    [self createViews];
    
    
}

#pragma 数据源数组初始化
-(void)SetDataArray {
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 42; i++) {
        NSString *str = [NSString stringWithFormat:@"/Users/yuxiaocong/Desktop/back/test2/ico/pic%d.png", i + 1 ];
        [_dataArray addObject:str];
    }
    
}

#pragma 页面布局
- (void)createViews {
    //开始UICollectionView布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //cell大小
    flowLayout.itemSize = CGSizeMake(kSCREEN_WIDTH / 9 / 6 * 5, kSCREEN_WIDTH / 9 / 6 * 5);
    //cell最小间距
    flowLayout.minimumInteritemSpacing = kSCREEN_WIDTH / 9 / 6 / 2;
    //每个cell间距
    flowLayout.sectionInset = UIEdgeInsetsMake(kSCREEN_WIDTH / 60, kSCREEN_WIDTH / 60, kSCREEN_WIDTH / 60, kSCREEN_WIDTH / 60);
    //头视图大小
    flowLayout.headerReferenceSize = CGSizeMake(kSCREEN_WIDTH, 50);
    //设置头视图悬停
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 50) collectionViewLayout:flowLayout];
    collectionView.backgroundColor= [UIColor whiteColor];
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //注册头视图
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //注册cell
    [collectionView registerClass:[ButtonCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:collectionView];
    
    //设置添加文字按钮
    UIButton *addTextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    
    //设置取消按钮
    
    
    //设置保存按钮
    
    
    
}

#pragma 设置cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    
    cell.insideImageView.image = [UIImage imageNamed:_dataArray[indexPath.row]];
    
    return cell;
}

#pragma cell个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


#pragma cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"第%ld个按钮", indexPath.row + 1);
}


#pragma 设置头视图UI
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.backgroundColor = [UIColor whiteColor];
    header.alpha = 0.8f;
    //显示文字的Label
    UILabel *label = [[UILabel alloc]initWithFrame:header.frame];
    label.text = @"Select Desired Label";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:32];
    label.textAlignment = NSTextAlignmentCenter;
    [header addSubview:label];
    //右上角的提示按钮
    UIButton *tipsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    tipsButton.frame = CGRectMake(kSCREEN_WIDTH - 50, 5, 40, 40);
    [tipsButton setImage:[UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test2/ico/问号-2.png"] forState:UIControlStateNormal];
    
    [header addSubview:tipsButton];
    
    return header;
}

#pragma 设置头视图的高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kSCREEN_WIDTH, 50);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSCREEN_WIDTH / 60;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSCREEN_WIDTH / 60;
}


@end
