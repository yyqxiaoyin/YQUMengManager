//
//  PWTShareSheetView.h
//  PopViewDemo
//
//  Created by Mopon on 16/5/24.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SheetClickIndexBlock)(NSInteger index);

@interface PWTShareSheetView : UIView

+(instancetype)shareSheetView;

-(void)showSheetViewWithAction:(SheetClickIndexBlock)block;

@end
