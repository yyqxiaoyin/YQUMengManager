//
//  YQUmengManager.m
//  UMengShareDemo
//
//  Created by Mopon on 16/6/14.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQUmengManager.h"

#import <UMSocialSinaSSOHandler.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import "UIViewController+YQUMeng.h"


//友盟key
static NSString *staticUMengAppKey;
static NSArray *staticPlatforms;

@implementation YQUmengManager


#pragma mark - =========配置=============
+(void)setUmengAppKey:(NSString *)appKey{
    [UMSocialData setAppKey:appKey];
    staticUMengAppKey = appKey;
    staticPlatforms = @[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline];
}

+(NSString *)getUmengAppKey{

    return staticUMengAppKey;
}

+(void)setSinaSSOWithSinaAppKey:(NSString *)sinaAppkey appSecret:(NSString *)sinaAppSecret RedirectURL:(NSString *)redirectURL{

    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:sinaAppkey secret:sinaAppSecret RedirectURL:redirectURL];
}

+(void)setWXAppId:(NSString *)wxApp_id appSecret:(NSString *)appSecret url:(NSString *)url{

    [UMSocialWechatHandler setWXAppId:wxApp_id appSecret:appSecret url:url];
    
    [self hiddenNotInstallPlatforms];
    
}

+(void)setQQAppId:(NSString *)QQApp_id appKey:(NSString *)appKey url:(NSString *)url{

    [UMSocialQQHandler setQQWithAppId:QQApp_id appKey:appKey url:url];
    [self hiddenNotInstallPlatforms];
}

+ (void)setSharePlatforms:(NSArray *)platforms{

    staticPlatforms = platforms;

}

#pragma mark - =========SSO回调============
+(BOOL)umengHandleOpenURL:(NSURL *)url{
    
    return [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - =========分享============

#pragma mark 自定义UI分享

+(void)shareTosina:(UIViewController *)vc title:(NSString *)title text:(NSString *)text url:(NSString *)url image:(id)image resourceType:(UMSocialUrlResourceType)resourceType{

    NSString *platFormName = UMShareToSina;
    [self shareToThirdWithViewController:vc title:title text:text url:url image:image resourceType:resourceType platFormName:platFormName];
    
}

+(void)shareToWeChat:(UIViewController *)vc title:(NSString *)title text:(NSString *)text url:(NSString *)url image:(id)image resourceType:(UMSocialUrlResourceType)resourceType weChatSourceType:(WeChatSourceType)weChatSourceType{
    
    NSString *platFormName =  weChatSourceType == WeChatSourceTypeTimeLine ? UMShareToWechatTimeline :UMShareToWechatSession;
    
    [self shareToThirdWithViewController:vc title:title text:text url:url image:image resourceType:resourceType platFormName:platFormName];
}

+(void)shareToSina:(UIViewController *)vc shareDataModel:(YQUMengShareDataModel *)model{
    
    [self shareTosina:vc title:model.title text:model.text url:model.url image:model.image resourceType:model.resourceType];
}

+(void)shareToWechat:(UIViewController *)vc shareDataModel:(YQUMengShareDataModel *)model{

    [self shareToWeChat:vc title:model.title text:model.text url:model.url image:model.image resourceType:model.resourceType weChatSourceType:model.weChatSourceType];

}

#pragma mark 友盟默认UI分享
+(void)presentSnsIconSheetView:(UIViewController *)vc text:(NSString *)text image:(id)image{

    [UMSocialSnsService presentSnsIconSheetView:vc appKey:staticUMengAppKey shareText:text shareImage:image shareToSnsNames:staticPlatforms delegate:vc];
    
}

#pragma mark - =========第三方登录============
+(void)umengLogin:(UIViewController *)vc loginPlatform:(YQUMengLoginType)loginPlatformType handle:(YQUMengLoginResponseHandle)responseHandle{

    
    NSString *platformName = [self getplatformNameWith:loginPlatformType];
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (responseHandle){
            responseHandle(response,loginPlatformType);
        }
        
    });
    
}

#pragma mark - =========私有方法============
//内部统一调的分享方法
+(void)shareToThirdWithViewController:(UIViewController *)vc title:(NSString *)title text:(NSString *)text url:(NSString *)url image:(id)image resourceType:(UMSocialUrlResourceType)resourceType platFormName:(NSString *)platFormName{
    
    
    [[UMSocialData defaultData].urlResource setResourceType:resourceType url:url];
    [UMSocialData defaultData].title = title;
    [UMSocialData defaultData].shareText = text;
    [[UMSocialControllerService defaultControllerService] setShareText:text shareImage:image socialUIDelegate:vc];
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platFormName];
    snsPlatform.snsClickHandler(vc,[UMSocialControllerService defaultControllerService],YES);
}

//根据传进来的类型返回友盟平台名字字符串
+(NSString *)getplatformNameWith:(YQUMengLoginType)type{

    NSString *platformName;
    switch (type) {
        case YQUMengLoginTypeWeChat:
            
            platformName =  UMShareToWechatSession;
            break;
        case YQUMengLoginTypeSina:
            
            platformName =  UMShareToSina;
            break;
        case YQUMengLoginTypeQQ:
            
            platformName =  UMShareToQQ;
            break;
            
        default:
            break;
    }
    return platformName;
}

//隐藏未安装客户端
+(void)hiddenNotInstallPlatforms{
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToSina,UMShareToWechatSession]];
}

@end

@implementation YQUMengShareDataModel



@end
