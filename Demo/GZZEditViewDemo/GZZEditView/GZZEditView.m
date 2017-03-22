//
//  GZZEditSignView.m
//  Callba
//
//  Created by Jonzzs on 16/7/19.
//  Copyright © 2016年 callda. All rights reserved.
//

#import "GZZEditView.h"
#import "AppDelegate.h"

/* 得到屏幕尺寸 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight 20

#define kBackgroundColor [UIColor colorWithWhite:0.5 alpha:0.8] // 阴影背景颜色
#define kEditViewColor [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0] // 输入框背景颜色
#define kTitleLabelFont [UIFont boldSystemFontOfSize:18.0f] // 标题文字字号
#define kLabelFont [UIFont systemFontOfSize:14.0f] // 普通文字字号

CGFloat const ANIMATION_DURATION = 0.3f; // 默认动画时间
CGFloat const PADDING = 15.0f; // 默认边距
CGFloat const CORNER_RADIUS = 5.0f; // 默认圆角
CGFloat const BORDER_WIDTH = 0.5f; // 默认边框宽度
CGFloat const LABEL_HEIGHT = 20.0f; // 默认文字高度

CGFloat const BUTTON_HEIGHT = 40.0f; // 确定按钮高度
CGFloat const BACK_VIEW_WIDTH = 300.0f; // 整个输入框的宽度
CGFloat const NUMBER_UPPER_LABEL_WIDTH = 70.0f; // 字数显示的宽度
CGFloat const CLOSE_BUTTON_SIZE = 45.0f; // 右上角 ✘ 的尺寸
CGFloat const PLACEHOLDER_PADDING_LEFT = 5.0f; // 输入框提示文字左边距
CGFloat const PLACEHOLDER_PADDING_TOP = 6.0f; // 输入框提示文字上边距

CGFloat const EDIT_VIEW_HEIGHT = 300.0f; // 默认输入框高度
NSInteger const TEXT_NUMBER_UPPER = 150; // 默认字数限制

@interface GZZEditView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *backView; // 背景框
@property (nonatomic, strong) UILabel *numberUpperLabel; // 显示文字字数
@property (nonatomic, strong) UILabel *titleLabel; // 标题
@property (nonatomic, strong) UIButton *closeButton; // 关闭按钮
@property (nonatomic, strong) UITextView *editTextView; // 编辑框
@property (nonatomic, strong) UILabel *placeholderLabel; // 提示文字
@property (nonatomic, strong) UIButton *button; // 确定按钮

@property (nonatomic, assign) CGFloat editViewHeight; // 输入框高度
@property (nonatomic, assign) CGFloat tmpEditViewHeight; // 输入框备用高度
@property (nonatomic, assign) NSInteger textNumberUpper; // 字数限制
@property (nonatomic, assign) BOOL allowEdit; // 是否允许编辑
@property (nonatomic, assign) BOOL allowTextUpper; // 是否限制输入文字上限

@property (nonatomic, copy) void (^onButtonClickedBlock)(NSString *editViewText); // 按钮的点击事件

@end

@implementation GZZEditView


- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        /* 默认参数 */
        self.editViewHeight = EDIT_VIEW_HEIGHT;
        self.textNumberUpper = TEXT_NUMBER_UPPER;
        self.allowEdit = YES;
        self.allowTextUpper = YES;
        
        /* 初始化视图 */
        [self initView];
        [self initLayout];
        
        /* 增加监听（当键盘出现或改变时） */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        /* 增加监听（当键盘退出时） */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


+ (instancetype)editViewWithButtonActionBlock:(void(^)(NSString *editViewText))block {
    
    GZZEditView *editView = [[self alloc] init];
    editView.onButtonClickedBlock = block;
    
    return editView;
}


/**
 初始化视图
 */
- (void)initView {
    
    self.backgroundColor = kBackgroundColor;
    self.alpha = 0;
    
    /* 背景框 */
    self.backView = [[UIView alloc] init];
    self.backView.layer.cornerRadius = CORNER_RADIUS;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    /* 默认字数限制 */
    self.numberUpperLabel = [[UILabel alloc] init];
    self.numberUpperLabel.font = kLabelFont;
    self.numberUpperLabel.textColor = [UIColor grayColor];
    [self.backView addSubview:self.numberUpperLabel];
    
    /* 标题 */
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"编辑";
    self.titleLabel.font = kTitleLabelFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.titleLabel];
    
    /* 关闭按钮 */
    self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.closeButton setTitle:@"✘" forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(hideEditView) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.closeButton];
    
    /* 输入框 */
    self.editTextView = [[UITextView alloc] init];
    self.editTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.editTextView.delegate = self;
    self.editTextView.layer.borderWidth = BORDER_WIDTH;
    self.editTextView.layer.cornerRadius = CORNER_RADIUS;
    self.editTextView.layer.masksToBounds = YES;
    self.editTextView.font = kLabelFont;
    self.editTextView.backgroundColor = kEditViewColor;
    [self.backView addSubview:self.editTextView];
    
    /* 提示文字 */
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = kLabelFont;
    self.placeholderLabel.textColor = [UIColor grayColor];
    self.placeholderLabel.text = @"请输入文字...";
    [self.editTextView addSubview:self.placeholderLabel];
    
    /* 确定按钮 */
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.layer.cornerRadius = CORNER_RADIUS;
    self.button.layer.masksToBounds = YES;
    self.button.titleLabel.font = kLabelFont;
    self.button.backgroundColor = [UIColor orangeColor];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button setTitle:@"确定" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(onButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.button];
}


/**
 初始化布局
 */
- (void)initLayout {
    
    /* 背景框 */
    self.backView.frame = CGRectMake((kScreenWidth - BACK_VIEW_WIDTH) / 2, (kScreenHeight - self.editViewHeight) / 2, BACK_VIEW_WIDTH, self.editViewHeight);
    
    /* 默认字数限制 */
    self.numberUpperLabel.frame = CGRectMake(PADDING, PADDING, NUMBER_UPPER_LABEL_WIDTH, LABEL_HEIGHT);
    
    /* 标题 */
    CGFloat titleLabelWidth = BACK_VIEW_WIDTH - (NUMBER_UPPER_LABEL_WIDTH + PADDING) * 2;
    self.titleLabel.frame = CGRectMake(NUMBER_UPPER_LABEL_WIDTH + PADDING, PADDING, titleLabelWidth, LABEL_HEIGHT);
    
    /* 关闭按钮 */
    self.closeButton.frame = CGRectMake(BACK_VIEW_WIDTH - CLOSE_BUTTON_SIZE, 0, CLOSE_BUTTON_SIZE, CLOSE_BUTTON_SIZE);
    
    /* 输入框 */
    CGFloat editTextViewWidth = BACK_VIEW_WIDTH - PADDING * 2;
    CGFloat editTextViewHeight = self.editViewHeight - PADDING * 4 - LABEL_HEIGHT - BUTTON_HEIGHT;
    self.editTextView.frame = CGRectMake(PADDING, LABEL_HEIGHT + PADDING * 2, editTextViewWidth, editTextViewHeight);
    
    /* 提示文字 */
    self.placeholderLabel.frame = CGRectMake(PLACEHOLDER_PADDING_LEFT, PLACEHOLDER_PADDING_TOP, editTextViewWidth - PLACEHOLDER_PADDING_LEFT * 2, LABEL_HEIGHT);
    
    /* 确定按钮 */
    CGFloat buttonWidth = BACK_VIEW_WIDTH - PADDING * 2;
    self.button.frame = CGRectMake(PADDING, PADDING * 3 + LABEL_HEIGHT + editTextViewHeight, buttonWidth, BUTTON_HEIGHT);
}


/**
 监听 键盘弹出

 @param aNotification 键盘信息
 */
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    /* 获取键盘的高度 */
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = aValue.CGRectValue;
    
    /* 输入框上移 */
    CGRect backViewFrame = self.backView.frame;
    CGFloat editViewBottomHeight = kScreenHeight - backViewFrame.origin.y - backViewFrame.size.height;
    CGFloat keyboardHeight = keyboardRect.size.height + PADDING;
    if (editViewBottomHeight < keyboardHeight) {
        
        [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
            
            /* 超出屏幕缩小高度 */
            CGFloat viewHeight = keyboardHeight + self.editViewHeight + PADDING + kStatusBarHeight;
            if (viewHeight > kScreenHeight) {
                
                self.tmpEditViewHeight = self.editViewHeight;
                self.editViewHeight -= viewHeight - kScreenHeight;
                [self initLayout];
            }
            
            CGRect backViewFrame = self.backView.frame;
            CGFloat editViewBottomHeight = kScreenHeight - backViewFrame.origin.y - backViewFrame.size.height;
            
            CGRect frame = self.frame;
            frame.origin.y = -(keyboardHeight - editViewBottomHeight);
            self.frame = frame;
        }];
    }
}


/**
 监听 键盘退出

 @param aNotification 键盘信息
 */
- (void)keyboardWillHide:(NSNotification *)aNotification {
    
    /* 输入框下移 */
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        
        if (self.tmpEditViewHeight > 0) {
            
            self.editViewHeight = self.tmpEditViewHeight;
            [self initLayout];
            self.tmpEditViewHeight = 0;
        }
        
        CGRect frame = self.frame;
        frame.origin.y = 0;
        self.frame = frame;
    }];
}


/**
 代理方法 输入内容改变

 @param textView 编辑框
 */
- (void)textViewDidChange:(UITextView *)textView {
    
    /* 隐藏提示文字 */
    if (textView.text.length < 1) self.placeholderLabel.hidden = NO;
    if (textView.text.length > 0) self.placeholderLabel.hidden = YES;
    
    if (self.allowTextUpper) {
        
        /* 超过字数停止输入 */
        if (textView.text.length > self.textNumberUpper) textView.text = [textView.text substringToIndex:self.textNumberUpper];
        
        /* 字数显示 */
        self.numberUpperLabel.text = [NSString stringWithFormat:@"%ld/%ld", textView.text.length, self.textNumberUpper];
    }
}


/**
 点击空白隐藏键盘

 @param touches 触点
 @param event 事件
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
}


/**
 确定按钮的点击事件
 */
- (void)onButtonClicked {
    
    [self hideEditView];
    
    if (self.onButtonClickedBlock) {
        
        self.onButtonClickedBlock([self getEditViewText]);
    }
}


#pragma mark - 接口

- (void)showEditView {
    
    /* 设置提示文字和字数限制 */
    if (self.editTextView.text.length < 1) self.placeholderLabel.hidden = NO;
    if (self.editTextView.text.length > 0) self.placeholderLabel.hidden = YES;
    if (self.allowTextUpper) {
        
        self.numberUpperLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.editTextView.text.length, self.textNumberUpper];
    }
    
    /* 显示视图 */
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:self];
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        if (self.allowEdit) {
            
            [self.editTextView becomeFirstResponder];
        }
    }];
}


- (void)hideEditView {
    
    /* 隐藏视图 */
    [self endEditing:YES];
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}


- (NSString *)getEditViewText {
    
    return self.editTextView.text;
}


- (void)setEditViewHeight:(CGFloat)height {
    
    _editViewHeight = height;
    [self initLayout];
}


- (void)setEditViewText:(NSString *)text {
    
    self.editTextView.text = text;
}


- (void)setTitle:(NSString *)title {
    
    self.titleLabel.text = title;
}


- (void)setPlaceholder:(NSString *)placeholder {
    
    self.placeholderLabel.text = placeholder;
}


- (void)setButtonColor:(UIColor *)color {
    
    [self.button setBackgroundColor:color];
}


- (void)setButtonTitle:(NSString *)title {
    
    [self.button setTitle:title forState:UIControlStateNormal];
}


- (void)setTextNumberUpper:(NSInteger)number {
    
    _textNumberUpper = number;
}


- (void)setAllowTextUpper:(BOOL)allowTextUpper {
    
    _allowTextUpper = allowTextUpper;
    self.numberUpperLabel.hidden = !allowTextUpper;
}


- (void)setAllowEdit:(BOOL)allowEdit {
    
    _allowEdit = allowEdit;
    self.editTextView.editable = allowEdit;
}

@end
