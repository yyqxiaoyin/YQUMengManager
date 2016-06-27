//
//  PWTSheetButton.m
//  PopViewDemo
//
//  Created by Mopon on 16/5/24.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "PWTSheetButton.h"
#import <Masonry.h>

@interface PWTSheetButton ()

@property (nonatomic ,strong)UILabel *label;

@property (nonatomic ,strong)UIImageView *topImageView;

@property (nonatomic ,strong)UIImage *image;

@property (nonatomic ,strong)NSString *title;

@end

@implementation PWTSheetButton

-(instancetype)initWithImage:(UIImage *)image title:(NSString *)title{

    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
        [self setUpviews];
    }
    return self;
}

-(void)setTextFont:(UIFont *)textFont{

    _textFont = textFont;
    _label.font = _textFont;
}
-(void)setUpviews{

    _label = [UILabel new];
    _label.textColor = [UIColor darkGrayColor];
    _label.text = self.title;
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
    _topImageView = [[UIImageView alloc]init];
    _topImageView.image = self.image;
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_topImageView];
    
    CGSize labelSize = [self labelAutoCalculateRectWith:_title Font:_label.font MaxSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(_image.size);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-labelSize.height/2-5);
        make.centerX.mas_equalTo(self.mas_centerX);
        
        
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(_topImageView.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(labelSize.height);
    }];
}
#pragma mark - 计算文字高度
- (CGSize)labelAutoCalculateRectWith:(NSString *)text Font:(UIFont *)font MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}
@end
