# GZZEditView

> 这是一个自己写的编辑框，非常轻量级，也可以作为提示框使用，用法非常简单 。

---

## 集成方法：

* 将 `GZZEditView.h` 和 `GZZEditView.m` 拷贝到项目中（后续会支持 `CocoaPods`集成）。
* 添加头文件 `#import "GZZEditView.h"` 。

## 基本用法：

#### 1. 作为编辑框使用

```
GZZEditView *editView = [GZZEditView editViewWithView:self.view];
[editView setTitle:@"标题"];
[editView addButtonActionWithBlock:^(NSString *editViewText) {
    
    NSLog(@"编辑框内容：%@", editViewText);
}];
[editView showEditView];
```

**效果图：**

![作为编辑框使用](http://upload-images.jianshu.io/upload_images/1930874-0658a7032ccd6c36.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2. 作为提示框使用

```
GZZEditView *editView = [GZZEditView editViewWithView:self.view];
[editView setTitle:@"标题"];
[editView setEditViewText:@"提示内容..."];
[editView setAllowTextUpper:NO]; // 不限制字数
[editView setAllowEdit:NO]; // 不允许编辑
[editView showEditView];
```

**效果图：**

![作为提示框使用](http://upload-images.jianshu.io/upload_images/1930874-5f03f9cb45d35ba4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 3. 自定义视图高度

```
GZZEditView *editView = [GZZEditView editViewWithView:self.view];
[editView setTitle:@"标题"];
[editView setTextNumberUpper:1000]; // 限制字数 1000
[editView setEditViewHeight:500]; // 高度 500
[editView addButtonActionWithBlock:^(NSString *editViewText) {
    
    NSLog(@"编辑框内容：%@", editViewText);
}];
[editView showEditView];
```

**效果图：**

![自定义视图高度](http://upload-images.jianshu.io/upload_images/1930874-7f02191e95d3ea09.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 所有的属性方法：

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
 添加按钮事件

 @param block 按钮事件的 block
 */
- (void)addButtonActionWithBlock:(void(^)(NSString *editViewText))block;
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

> 大致用法就是这样，有不足的地方可以[提在这里](http://www.jianshu.com/p/80fe73dda5e2)，持续更新，大家可以把例子 `clone` 下来看一下，后续会支持 `CocoaPods` 集成，大家也可以到 [我的简书](http://www.jianshu.com/u/63659e722f3b) 去看看，会不定期更新一些【iOS 开发】的常用知识与方法。