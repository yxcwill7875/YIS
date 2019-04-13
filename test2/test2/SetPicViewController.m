//
//  SetPicViewController.m
//  test2
//
//  Created by 余晓聪 on 2019/4/10.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "SetPicViewController.h"
#import "ButtonCollectionViewCell.h"
#import "SelectPicViewController.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SetPicViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation SetPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    //初始化数据源数组
    _dataArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    //页面布局
    [self createViews];
    
    
}

#pragma 页面布局方法
- (void)createViews {
    //开始UICollectionView布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //每个按钮的大小
    flowLayout.itemSize = CGSizeMake(kSCREEN_WIDTH / 5 , kSCREEN_HEIGHT / 2.5);
    //每个按钮的最小间距
    flowLayout.minimumInteritemSpacing = 0;
    //每个按钮的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
  
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) collectionViewLayout:flowLayout];
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.backgroundColor = [UIColor orangeColor];
    
    //注册cell
    [collectionView registerClass:[ButtonCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:collectionView];
    
    //设置标题Label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, kSCREEN_HEIGHT - kSCREEN_HEIGHT / 8, flowLayout.itemSize.width * 3, kSCREEN_HEIGHT / 8)];
    titleLabel.text = @"  My  Boat's  Control  Panel";
    titleLabel.font = [UIFont systemFontOfSize:30];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = self.view.backgroundColor;
    
    [self.view addSubview:titleLabel];
    
    //设置取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setFrame:CGRectMake(titleLabel.frame.size.width + titleLabel.frame.origin.x + 10, titleLabel.frame.origin.y, flowLayout.itemSize.width - 20, titleLabel.frame.size.height)];
    
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelButton setTintColor:[UIColor blackColor]];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:24];
    //设置button弧度
    cancelButton.layer.cornerRadius = 10.0f;
    
    [cancelButton addTarget:self action:@selector(clickCancelButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelButton];
    
    //设置保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setFrame:CGRectMake(cancelButton.frame.size.width + cancelButton.frame.origin.x + 10, titleLabel.frame.origin.y, cancelButton.frame.size.width, titleLabel.frame.size.height)];
    
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    saveButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [saveButton setTintColor:[UIColor blackColor]];
    saveButton.backgroundColor = [UIColor whiteColor];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:24];
    //设置button弧度
    saveButton.layer.cornerRadius = cancelButton.layer.cornerRadius;
    
    [saveButton addTarget:self action:@selector(clickSaveButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];
    
}

#pragma 设置按钮调用方法
- (void)clickSaveButtonMethod {
    
   
    
    NSLog(@"保存设置");
}

- (void)clickCancelButtonMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma collectionView的cell数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

#pragma collectionView的cell样式
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSString *str = [NSString stringWithFormat:@"/Users/yuxiaocong/Desktop/back/test/ico/%@", _dataArray[indexPath.row]];
    
    cell.insideLabel.text = _dataArray[indexPath.row];
    
    cell.backgroundColor = self.view.backgroundColor;
    
    cell.cellImageView.image = [UIImage imageNamed:str];
    
    //设置间隔线
    if (indexPath.row == 4 || indexPath.row == 9) {
        cell.leftLineImageView.alpha = 0.0f;
    }
    if (indexPath.row > 4 ) {
        cell.downLineImageView.alpha = 0.0f;
        
    }
    
    return cell;
}

#pragma cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    SelectPicViewController *spvc = [[SelectPicViewController alloc]init];
    spvc.row = indexPath.row;
    
    [self.navigationController pushViewController:spvc animated:YES];
    
}


//cell点击时执行方法
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    //    if (highlighted == YES) {
    //        coverView.alpha = .2;
    //    }else{
    //        coverView.alpha = 0;
    //    }
    //    [super setHighlighted:highlighted animated:animated];
}


// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
