//
//  ViewController.m
//  UMengShareDemo
//
//  Created by Mopon on 16/6/14.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ViewController.h"
#import <UMSocial.h>
#import "YQUmengManager.h"
#import "PWTShareSheetView.h"

@interface ViewController ()

@end

@implementation ViewController

//第三方登录
- (IBAction)thirdLogin:(id)sender {
    
    [YQUmengManager umengLogin:self loginPlatform:YQUMengLoginTypeSina handle:^(UMSocialResponseEntity *response, YQUMengLoginType loginPlatformType) {
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSLog(@"SSO授权成功");
        }
        NSLog(@"%@",response);
    }];

}

//分享到微博（自定义UI）
- (IBAction)shareToSinaCustumUI:(id)sender {
    
    [self showCustumUI:NO];

}
//分享到微信（自定义UI）
- (IBAction)shareToWeChatCustumUi:(id)sender {
    
    [self showCustumUI:NO];

}
//分享到微博（自定义UI，model方式）
- (IBAction)shareToSinaModel:(id)sender {
    
    [self showCustumUI:YES];

}
//分享到微信（自定义UI，model方式）
- (IBAction)shareToWeChatModel:(id)sender {
   
    [self showCustumUI:YES];
}

//分享（友盟默认UI）
- (IBAction)shareNomalUI:(id)sender {
    
    [YQUmengManager presentSnsIconSheetView:self text:@"百度" image:[UIImage imageNamed:@"meinv"]];
}


-(void)showCustumUI:(BOOL)isModelMode{

    __block typeof(self)weakSelf = self;
    [[PWTShareSheetView shareSheetView]showSheetViewWithAction:^(NSInteger index) {
        
        NSLog(@"%lu",index);
        
        switch (index) {
            case 0:
                [weakSelf shareWeChat:isModelMode];
                break;
            case 1:
                [weakSelf shareSina:isModelMode];
                break;
                
            default:
                break;
        }
    }];
}


-(void)shareSina:(BOOL)isModelMode{
    
    if (isModelMode) {
        
        YQUMengShareDataModel *model = [[YQUMengShareDataModel alloc]init];
        model.text = @"百度";
        model.title = @"百度";
        model.url = @"http://v.youku.com/v_show/id_XNjQ1NjczNzEy.html?f=21207816&ev=2";
        model.image = [UIImage imageNamed:@"meinv"];
        model.resourceType = UMSocialUrlResourceTypeVideo;
        model.weChatSourceType = WeChatSourceTypeSession;
        
        [YQUmengManager shareToWechat:self shareDataModel:model];
        
    }else{
        
        [YQUmengManager shareTosina:self
                              title:@"百度"
                               text:@"百度"
                                url:@"http://v.youku.com/v_show/id_XNjQ1NjczNzEy.html?f=21207816&ev=2"
                              image:[UIImage imageNamed:@"meinv"]
                       resourceType:UMSocialUrlResourceTypeVideo];
    }
    
}
-(void)shareWeChat:(BOOL)isModelMode{
    
    if (isModelMode) {
        
        YQUMengShareDataModel *model = [[YQUMengShareDataModel alloc]init];
        model.text = @"百度";
        model.title = @"百度";
        model.url = @"http://v.youku.com/v_show/id_XNjQ1NjczNzEy.html?f=21207816&ev=2";
        model.image = [UIImage imageNamed:@"meinv"];
        model.resourceType = UMSocialUrlResourceTypeVideo;
        
        [YQUmengManager shareToSina:self shareDataModel:model];
        
    }else{
    
        [YQUmengManager shareToWeChat:self
                                title:@"百度"
                                 text:@"百度"
                                  url:@"http://www.baidu.com"
                                image:[UIImage imageNamed:@"meinv"]
                         resourceType:UMSocialUrlResourceTypeWeb
                     weChatSourceType:WeChatSourceTypeSession];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
