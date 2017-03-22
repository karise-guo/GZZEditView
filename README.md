# GZZEditView

> 这是一个轻量级的编辑框，也可以作为提示框使用，用法非常简单。

---

## 基本用法：

#### 1. 作为编辑框使用

```
GZZEditView *editView = [GZZEditView editViewWithButtonActionBlock:^(NSString *editViewText) {
        
    NSLog(@"编辑框内容：%@", editViewText);
}];
[editView setTitle:@"标题"];
[editView showEditView];
```

**效果图：**

![作为编辑框使用](http://upload-images.jianshu.io/upload_images/1930874-7a8d007039fb1e58.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2. 作为提示框使用

```
GZZEditView *editView = [GZZEditView editViewWithButtonActionBlock:nil];
[editView setTitle:@"标题"];
[editView setEditViewText:@"提示内容..."];
[editView setAllowTextUpper:NO]; // 不限制字数
[editView setAllowEdit:NO]; // 不允许编辑
[editView showEditView];
```

**效果图：**

![作为提示框使用](http://upload-images.jianshu.io/upload_images/1930874-38062c6b949b0925.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 3. 自定义视图高度

```
GZZEditView *editView = [GZZEditView editViewWithButtonActionBlock:^(NSString *editViewText) {
        
    NSLog(@"编辑框内容：%@", editViewText);
}];
[editView setTitle:@"标题"];
[editView setTextNumberUpper:1000]; // 限制字数 1000
[editView setEditViewHeight:500]; // 高度 500
[editView showEditView];
```

**效果图：**

![自定义视图高度](http://upload-images.jianshu.io/upload_images/1930874-2da7dcd39905da01.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 所有的属性方法

```
/**
 显示输入框
 */
- (void)showEditView;
```

```
/**
 关闭输入框
 */
- (void)hideEditView;
```

```
/**
 得到输入框的内容

 @return 输入框内容
 */
- (NSString *)getEditViewText;
```

```
/**
 设置编辑框文字

 @param text 文字
 */
- (void)setEditViewText:(NSString *)text;
```

```
/**
 设置输入框高度
 
 @param height 高度（不设置默认180）
 */
- (void)setEditViewHeight:(CGFloat)height;
```

```
/**
 设置标题文字

 @param title 标题（不设置默认 编辑）
 */
- (void)setTitle:(NSString *)title;
```

```
/**
 设置提示文字

 @param placeholder 提示文字（不设置默认 请输入内容...）
 */
- (void)setPlaceholder:(NSString *)placeholder;
```

```
/**
 设置确定按钮的颜色

 @param color 颜色（不设置默认橙色）
 */
- (void)setButtonColor:(UIColor *)color;
```

```
/**
 设置确定按钮的文字

 @param title 按钮文字（不设置默认 确定）
 */
- (void)setButtonTitle:(NSString *)title;
```

```
/**
 设置字数上限

 @param number 字数上线（不设置默认 150）
 */
- (void)setTextNumberUpper:(NSInteger)number;
```

```
/**
 设置是否限制输入文字上限
 
 @param allowTextUpper 是否限制输入文字上限（不设置默认 YES）
 */
- (void)setAllowTextUpper:(BOOL)allowTextUpper;
```

```
/**
 设置是否允许编辑

 @param allowEdit 是否允许编辑（不设置默认 YES）
 */
- (void)setAllowEdit:(BOOL)allowEdit;
```

---

> 大致用法就是这样，有不足的地方可以提出来，持续更新，大家也可以到 [我的简书](http://www.jianshu.com/u/63659e722f3b) 去看看，会不定期更新一些【iOS 开发】的常用知识与方法。

**将来的你，一定会感激现在拼命的自己，愿作者与读者的开发之路无限美好，另转载请注明原作者与原文链接，谢谢。**