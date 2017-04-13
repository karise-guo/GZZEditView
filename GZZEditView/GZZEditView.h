//
//  GZZEditSignView.h
//  Callba
//
//  Created by Jonzzs on 16/7/19.
//  Copyright © 2016年 callda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZZEditView : UIView


+ (instancetype)editViewWithView:(UIView *)view;


/**
 显示输入框
 */
- (void)showEditView;


/**
 关闭输入框
 */
- (void)hideEditView;


/**
 添加按钮事件

 @param block 按钮事件的 block
 */
- (void)addButtonActionWithBlock:(void(^)(NSString *editViewText))block;


/**
 得到输入框的内容

 @return 输入框内容
 */
- (NSString *)getEditViewText;


/**
 设置编辑框文字

 @param text 文字
 */
- (void)setEditViewText:(NSString *)text;


/**
 设置输入框高度
 
 @param height 高度（不设置默认180）
 */
- (void)setEditViewHeight:(CGFloat)height;


/**
 设置标题文字

 @param title 标题（不设置默认 编辑）
 */
- (void)setTitle:(NSString *)title;


/**
 设置提示文字

 @param placeholder 提示文字（不设置默认 请输入内容...）
 */
- (void)setPlaceholder:(NSString *)placeholder;


/**
 设置确定按钮的颜色

 @param color 颜色（不设置默认橙色）
 */
- (void)setButtonColor:(UIColor *)color;


/**
 设置确定按钮的文字

 @param title 按钮文字（不设置默认 确定）
 */
- (void)setButtonTitle:(NSString *)title;


/**
 设置字数上限

 @param number 字数上线（不设置默认 150）
 */
- (void)setTextNumberUpper:(NSInteger)number;


/**
 设置是否限制输入文字上限
 
 @param allowTextUpper 是否限制输入文字上限（不设置默认 YES）
 */
- (void)setAllowTextUpper:(BOOL)allowTextUpper;


/**
 设置是否允许编辑

 @param allowEdit 是否允许编辑（不设置默认 YES）
 */
- (void)setAllowEdit:(BOOL)allowEdit;

@end
