# sinaweibo
this project is a copy of sina weibo.

####alcatraz.io  管理Xcode插件
####www.pc6.com下载软件

###1.根视图是一个`UITabBarController`,然后自定义了一个`UITabBar`的子类,并根据需求自定了上面的`UIButton`.
####a.类的封装性，通过写一个对外接口property的setter函数实现一些控件自身其他属性的定制。

###2.自定义的API为限制参数的范围可以使用`NSException`类的对象，如下列例子：
```Objective-C
- (void)setRatio:(CGFloat)ratio {

    if (ratio < 0 || ratio > 1) {
        NSException *exception = [[NSException alloc] initWithName:@"异常提示" reason:@"参数范围应为0~1" userInfo:nil];
        @throw exception;
    } else {
        _ratio = ratio;
    }
}
```
###3.`UIButton`类自带了一个`UIImgeView`对象和一个titleLable.这俩者的frame可以在下列方法中设置
```Objective-C
//生成按钮内部图片的位置(frame) contentRect为按钮自身的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = CGRectGetWidth(contentRect);
    CGFloat imageH = CGRectGetHeight(contentRect) * self.ratio;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

//生成按钮内部titleLable的位置(frame)
- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetHeight(contentRect) * _ratio;
    CGFloat titleW = CGRectGetWidth(contentRect);
    CGFloat titleH = CGRectGetHeight(contentRect) * (1 - self.ratio);
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}
```
