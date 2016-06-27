//
//  YQUmengManager.h
//  UMengShareDemo
//
//  Created by Mopon on 16/6/14.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UMSocial.h>
@class YQUMengShareDataModel;

/**
 分享到微信分几种类型：1.微信好友 2.微信朋友圈 3.微信收藏
 */
typedef enum : NSUInteger {
    WeChatSourceTypeSession,//微信好友
    WeChatSourceTypeTimeLine,//朋友圈
} WeChatSourceType;

//登录平台
typedef enum : NSUInteger {
    YQUMengLoginTypeWeChat,//微信
    YQUMengLoginTypeSina,//新浪
    YQUMengLoginTypeQQ,//QQ
} YQUMengLoginType;

typedef void(^YQUMengLoginResponseHandle)(UMSocialResponseEntity *response ,YQUMengLoginType loginPlatformType);

@interface YQUmengManager : NSObject

#pragma mark - ============配置区=================

/**
 *  设置友盟AppKey
 *
 *  @param appKey 友盟appkey
 */
+(void)setUmengAppKey:(NSString *)appKey;

/**
 *  获取友盟AppKey提供外部使用
 *
 *  @return 返回友盟的appkey
 */
+(NSString *)getUmengAppKey;

/**
 *  集成新浪SSO
 *
 *  @param sinaAppkey    新浪app key
 *  @param sinaAppSecret 新浪app secret
 *  @param redirectURL   回调地址
 */
+(void)setSinaSSOWithSinaAppKey:(NSString *)sinaAppkey appSecret:(NSString *)sinaAppSecret RedirectURL:(NSString *)redirectURL;

/**
 *  集成微信
 *
 *  @param wxApp_id  微信app id
 *  @param appSecret 微信appSecret
 *  @param url       微信消息分享网页类型的url地址
 */
+(void)setWXAppId:(NSString *)wxApp_id appSecret:(NSString *)appSecret url:(NSString *)url;


/**
 *  集成QQ
 *
 *  @param QQApp_id QQ app id
 *  @param appKey   QQ app key
 *  @param url      分享URL链接
 */
+(void)setQQAppId:(NSString *)QQApp_id appKey:(NSString *)appKey url:(NSString *)url;

/**
 *  设置需要显示的分享平台，传nil为全部平台 默认为：新浪微博、微信朋友圈、微信好友
 *
 *  @param platforms 数组
 */
+(void)setSharePlatforms:(NSArray *)platforms;


/**
 *  友盟SSO回调
 */
+(BOOL)umengHandleOpenURL:(NSURL *)url;

#pragma mark - ============分享区=================

#pragma mark 自定义UI分享

/**
 *  分享到新浪
 *
 *  @param vc           分享回调的控制器
 *  @param title        分享的标题
 *  @param text         分享的内容
 *  @param url          分享内容点击跳转的链接
 *  @param image        分享的图片(可以是UIImage也可以是NSData类型)
 *  @param resourceType 多媒体信息的类型
 */
+ (void)shareTosina:(UIViewController *)vc title:(NSString *)title text:(NSString *)text url:(NSString *)url image:(id)image resourceType:(UMSocialUrlResourceType)resourceType;

/**
 *  分享到微信（自定义UI用)
 *
 *  @param vc    分享回调的控制器
 *  @param title 分享的标题
 *  @param text  分享的内容
 *  @param url   分享内容跳转的链接
 *  @param image 分享的图片(可以是UIImage也可以是NSData类型)
 *  @param resourceType  微信消息类型
 *  @param weChatSourceType  分享到微信的朋友圈还是微信好友
 */
+(void)shareToWeChat:(UIViewController *)vc title:(NSString *)title text:(NSString *)text url:(NSString *)url image:(id)image resourceType:(UMSocialUrlResourceType)resourceType weChatSourceType:(WeChatSourceType)weChatSourceType;

/**
 *  使用模型数据分享到新浪
 *
 *  @param vc    分享回调的控制器
 *  @param model 分享的数据模型
 */
+(void)shareToSina:(UIViewController *)vc shareDataModel:(YQUMengShareDataModel *)model;

/**
 *  使用模型数据分享到微信
 *
 *  @param vc    分享回调的控制器
 *  @param model 分享的数据模型
 */
+(void)shareToWechat:(UIViewController *)vc shareDataModel:(YQUMengShareDataModel *)model;



#pragma mark 友盟默认UI分享
/**
 *  分享
 *
 *  @param vc    弹出分享框的控制器
 *  @param text  分享的内容
 *  @param image 分享的图片
 */
+(void)presentSnsIconSheetView:(UIViewController *)vc text:(NSString *)text image:(id)image;


#pragma mark - ============第三方登录区=================
/**
 *  第三方登录
 *
 *  @param vc             登录的控制器
 *  @param loginPlatform  登录的平台
 *  @param responseHandle 登录回调
 */
+(void)umengLogin:(UIViewController *)vc loginPlatform:(YQUMengLoginType)loginPlatformType handle:(YQUMengLoginResponseHandle)responseHandle;


@end

#pragma mark ============分享数据模型=================
@interface YQUMengShareDataModel : NSObject

/** 分享的标题 */
@property (nonatomic ,strong)NSString *title;

/** 分享的文字 */
@property (nonatomic ,strong)NSString *text;

/** 分享内容点击跳转链接 */
@property (nonatomic ,strong)NSString *url;

/** 分享的图片 */
@property (nonatomic ,strong)id image;

/** 分享的类型 */
@property (nonatomic ,assign)UMSocialUrlResourceType resourceType;

/** 如果是分享到微信。需选择是微信朋友圈还是微信好友 */
@property (nonatomic ,assign)WeChatSourceType weChatSourceType;

@end
