//
//  SetViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/9.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SetViewController.h"
#import "SetCollectionViewCell.h"
#import "SetPicViewController.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SetViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSArray *dataArray;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    _dataArray = [NSArray arrayWithObjects:@"Labels", @"Mometary Buttons", @"Panels", @"Device Management", @"Setting", @"About", nil];
    
    [self createViews];
    
}

- (void)createViews {
    //初始化U集合视图布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //每个cell大小
    flowLayout.itemSize = CGSizeMake(kSCREEN_WIDTH / 2 - 50, kSCREEN_HEIGHT / 5);
    flowLayout.sectionInset = UIEdgeInsetsMake(kSCREEN_HEIGHT / 16, kSCREEN_HEIGHT / 16, kSCREEN_HEIGHT / 16, kSCREEN_HEIGHT / 16);
    //cell间距
    flowLayout.minimumInteritemSpacing = kSCREEN_HEIGHT / 16;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) collectionViewLayout:flowLayout];
    
    
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell
    [_collectionView registerClass:[SetCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:_collectionView];
    
    //设置返回button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.backgroundColor = [UIColor whiteColor];
    [backButton setTintColor:[UIColor blackColor]];
    backButton.frame = CGRectMake(10, kSCREEN_HEIGHT - 50, 100, 60);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(ClickBackButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
}

#pragma 返回按钮方法
- (void)ClickBackButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma cell个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
    
}

#pragma cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.label.text = _dataArray[indexPath.row];
    
    return cell;
    
}

#pragma cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SetPicViewController *stvc = [[SetPicViewController alloc] init];
    
    
    switch (indexPath.row) {
        case 0:
            
            [self.navigationController pushViewController:stvc animated:YES];
            
            
            NSLog(@"%@", _dataArray[indexPath.row]);
            break;
        case 1:
            NSLog(@"%@", _dataArray[indexPath.row]);
            break;
        case 2:
            NSLog(@"%@", _dataArray[indexPath.row]);
            break;
        case 3:
            NSLog(@"%@", _dataArray[indexPath.row]);
            break;
        case 4:
            NSLog(@"%@", _dataArray[indexPath.row]);
            break;
        
        default:
            NSLog(@"%@", _dataArray[indexPath.row]);
            break;
    }
    
}


//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(kSCREEN_WIDTH / 2 - kSCREEN_HEIGHT / 4, kSCREEN_HEIGHT / 4);
//}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSCREEN_HEIGHT / 16 ;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSCREEN_HEIGHT / 14;
}


@end
