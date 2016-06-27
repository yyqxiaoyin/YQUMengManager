//
//  PWTSheetButton.h
//  PopViewDemo
//
//  Created by Mopon on 16/5/24.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWTSheetButton : UIButton

-(instancetype)initWithImage:(UIImage *)image title:(NSString *)title;

@property (nonatomic ,strong)UIFont* textFont;

@end
