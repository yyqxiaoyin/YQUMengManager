//
//  PWTShareSheetView.m
//  PopViewDemo
//
//  Created by Mopon on 16/5/24.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "PWTShareSheetView.h"
#import <Masonry.h>
#import "PWTSheetButton.h"

#define MAIN_SCREEN_RECT [UIScreen mainScreen].bounds
#define BTN_DEFAULT_WIDTH MAIN_SCREEN_RECT.size.width/4

#define DEFAULT_MARGIN 10

@interface PWTShareSheetView ()

@property (nonatomic,copy) SheetClickIndexBlock block;

@property (nonatomic ,strong)UIWindow *sheetWindow;

@property (nonatomic ,strong)UIView *sheetView;

@property (nonatomic ,strong)UILabel *titleLabel;

@property (nonatomic ,strong)PWTSheetButton *wechatFriendsBtn;

@property (nonatomic ,strong)PWTSheetButton *wechatTimeLineBtn;

@end

PWTShareSheetView *bgView;

@implementation PWTShareSheetView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self dismiss];
}

+(instancetype)shareSheetView{
    
    static PWTShareSheetView *sheetView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sheetView = [[self alloc] init];
        
    });
    return sheetView;
}

-(void)showSheetViewWithAction:(SheetClickIndexBlock)block{

    self.block = [block copy];
    
    [self setUpBgViewWithBlock:block];
    [self setupSubViews];
}

-(void)setupSubViews{

    
    _sheetView = [[UIView alloc]init];
    _sheetView.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor darkGrayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    _titleLabel.text = @"分享到";
    
    
    _wechatFriendsBtn =[[PWTSheetButton alloc]initWithImage:[UIImage imageNamed:@"WechatFriends"] title:@"微信好友"];
    _wechatFriendsBtn.tag = 0;
    _wechatFriendsBtn.textFont = [UIFont systemFontOfSize:13];
    [_wechatFriendsBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:_wechatFriendsBtn];
    
    _wechatTimeLineBtn =[[PWTSheetButton alloc]initWithImage:[UIImage imageNamed:@"WeChatTimeLine"] title:@"朋友圈"];
    _wechatTimeLineBtn.tag = 1;
    _wechatTimeLineBtn.textFont = [UIFont systemFontOfSize:13];
    [_wechatTimeLineBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:_wechatTimeLineBtn];
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]) {
        
        [self hideNotInstallAppBtn];
        
    }
    
    [_sheetView addSubview:_titleLabel];
    [bgView addSubview:_sheetView];
    [self layoutViews];
}

-(void)hideNotInstallAppBtn{

    [_sheetView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[PWTSheetButton class]]) {
            
            obj.hidden = YES;
        }
        
    }];
    
}
-(void)btnClick:(UIButton *)sender{

    if (self.block) {
        
        self.block(sender.tag);
        self.block = nil;
        [self dismiss];
    }
}

-(void)layoutViews{
    
    [_titleLabel sizeToFit];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BTN_DEFAULT_WIDTH, _titleLabel.bounds.size.height));
        make.centerX.mas_equalTo(_sheetView.mas_centerX);
        make.top.mas_equalTo(_sheetView.mas_top).offset(DEFAULT_MARGIN);
    }];
    
    [_wechatFriendsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(BTN_DEFAULT_WIDTH, BTN_DEFAULT_WIDTH));
        make.right.mas_equalTo(_sheetView.mas_centerX);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(DEFAULT_MARGIN);
    }];
    
    
    [_wechatTimeLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(BTN_DEFAULT_WIDTH, BTN_DEFAULT_WIDTH));
        make.left.mas_equalTo(_sheetView.mas_centerX);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(DEFAULT_MARGIN);
    }];
    
    
    
    CGFloat sheetViewH =_titleLabel.bounds.size.height+BTN_DEFAULT_WIDTH +DEFAULT_MARGIN*2;
    [_sheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(bgView.mas_left);
        make.right.mas_equalTo(bgView.mas_right);
        make.top.mas_equalTo(bgView.mas_bottom);
        make.height.mas_equalTo(@(sheetViewH));
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        bgView.alpha = 1;
        _sheetView.transform = CGAffineTransformMakeTranslation(0, - sheetViewH);
    }];
}

-(void)setUpBgViewWithBlock:(SheetClickIndexBlock)block{

    self.sheetWindow= [UIApplication sharedApplication].keyWindow;
    
    bgView = [PWTShareSheetView shareSheetView];
    bgView.frame = self.sheetWindow.bounds;
    bgView.backgroundColor = [UIColor colorWithHue:0
                                        saturation:0
                                        brightness:0
                                             alpha:0.1];
    
    [self.sheetWindow addSubview:bgView];
}

-(void)dismiss{

    [UIView animateWithDuration:0.25 animations:^{
        bgView.alpha = 0;
        _sheetView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [_sheetView removeFromSuperview];
        [bgView removeFromSuperview];
        [_sheetWindow removeFromSuperview];
    }];
}

@end
