//
//  ViewController.m
//  GZZEditViewDemo
//
//  Created by Jonzzs on 2017/3/22.
//  Copyright © 2017年 Jonzzs. All rights reserved.
//

#import "ViewController.h"
#import "GZZEditView.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 作为编辑框使用
 */
- (IBAction)editViewButtonClick:(id)sender {
    
    GZZEditView *editView = [GZZEditView editViewWithButtonActionBlock:^(NSString *editViewText) {
        
        NSLog(@"编辑框内容：%@", editViewText);
    }];
    [editView setTitle:@"标题"];
    [editView showEditView];
}


/**
 作为提示框使用
 */
- (IBAction)alertViewButtonClicked:(id)sender {
    
    GZZEditView *editView = [GZZEditView editViewWithButtonActionBlock:nil];
    [editView setTitle:@"标题"];
    [editView setEditViewText:@"提示内容..."];
    [editView setAllowTextUpper:NO]; // 不限制字数
    [editView setAllowEdit:NO]; // 不允许编辑
    [editView showEditView];
}


/**
 自定义视图高度
 */
- (IBAction)changeEditViewHeight:(id)sender {
    
    GZZEditView *editView = [GZZEditView editViewWithButtonActionBlock:^(NSString *editViewText) {
        
        NSLog(@"编辑框内容：%@", editViewText);
    }];
    [editView setTitle:@"标题"];
    [editView setTextNumberUpper:1000]; // 限制字数 1000
    [editView setEditViewHeight:500]; // 高度 500
    [editView showEditView];
}

@end
