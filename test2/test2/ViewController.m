//
//  ViewController.m
//  test
//
//  Created by 余晓聪 on 2019/4/2.
//  Copyright © 2019年 余晓聪. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ButtonCollectionViewCell.h"
#import "SetViewController.h"

#define kIs_iPhoneX (kSCREEN_WIDTH == 375.f && kSCREEN_HEIGHT == 812.f)
#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    //横屏
    [self setRotationMethod];
    
    //初始化数据源数组
    _dataArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    //页面布局
    [self createViews];
    
    
}

#pragma 页面布局方法
- (void)createViews {
    //开始UICollecView布局
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
    
    //初始化电池label
    UILabel *batteryLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, kSCREEN_HEIGHT - kSCREEN_HEIGHT / 8, flowLayout.itemSize.width, kSCREEN_HEIGHT / 8)];
    batteryLabel.text = @"DC 13.4V";
    batteryLabel.backgroundColor = [UIColor blackColor];
    batteryLabel.textColor = [UIColor whiteColor];
    batteryLabel.textAlignment = NSTextAlignmentCenter;
    batteryLabel.font = [UIFont systemFontOfSize:24];
    
    [self.view addSubview:batteryLabel];
    
    //初始化电池图片
    UIImageView *batteryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(batteryLabel.frame.origin.x + batteryLabel.frame.size.width, batteryLabel.frame.origin.y, batteryLabel.frame.size.width, batteryLabel.frame.size.height)];
    [batteryImageView setImage:[UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test/ico/battery.png"]];
    
    [self.view addSubview:batteryImageView];
    
    //设置标题Label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH / 2, batteryImageView.frame.origin.y, kSCREEN_WIDTH / 2 - batteryImageView.frame.size.height, batteryImageView.frame.size.height)];
    titleLabel.text = @"  My  Boat's  Control  Panel";
    titleLabel.font = [UIFont systemFontOfSize:24];
    titleLabel.textColor = batteryLabel.textColor;
    titleLabel.backgroundColor = batteryImageView.backgroundColor;
    
    [self.view addSubview:titleLabel];
    
    //设置按钮
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [setButton setFrame:CGRectMake(titleLabel.frame.size.width + titleLabel.frame.origin.x, titleLabel.frame.origin.y, titleLabel.frame.size.height, titleLabel.frame.size.height)];
    [setButton setBackgroundImage:[UIImage imageNamed:@"/Users/yuxiaocong/Desktop/back/test/ico/shezhi.png"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(clickSetButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:setButton];
    
}

#pragma 设置按钮调用方法
- (void)clickSetButtonMethod {
    
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
    
    NSLog(@"xiayiye");
}

#pragma 横屏方法
- (void)setRotationMethod {
    //横屏
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    
    [self setNewOrientation:YES];//调用转屏代码
    
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
    
    NSLog(@"第%ld个按钮", indexPath.row + 1);
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
    

#pragma 横屏方法
- (void)setNewOrientation:(BOOL)fullscreen

{
    
    if (fullscreen) {
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }else{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }
    
}







//- (void)touchActionByFirstButton:(UIButton *)firstButton {
//
//    firstButton.backgroundColor = [UIColor purpleColor];
//    NSLog(@"第一个按钮");
//}

@end
