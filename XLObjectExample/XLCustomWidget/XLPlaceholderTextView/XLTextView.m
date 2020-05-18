//
//  XLTextView.m
//  XLComProject
//
//  Created by GDXL2012 on 2019/11/24.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import "XLTextView.h"

@interface XLTextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel   *placeholderLabel;
@property (nonatomic, assign) CGFloat   textViewHeight;   // 缓存高度
@end

@implementation XLTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [super setDelegate:self];
        _textViewHeight = 0.0f;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [super setDelegate:self];
        _textViewHeight = 0.0f;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_placeholderLabel) {
        [self updatePlaceholderLabelLayout];
    }
}

-(void)updatePlaceholderLabelLayout{
    CGPoint offset      = self.contentOffset;
    UIEdgeInsets inset1 = self.contentInset;
    UIEdgeInsets inset2 = self.textContainerInset;
    CGFloat linePadding = self.textContainer.lineFragmentPadding;
    
    CGFloat xOffset = offset.x + inset1.left + inset2.left + linePadding;
    CGFloat rOffset = inset1.left + inset2.left + linePadding;
    CGFloat yOffset = offset.y + inset1.top + inset2.top;
    
    NSLayoutConstraint *leftLayout = [NSLayoutConstraint constraintWithItem:_placeholderLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:xOffset];
    [self addConstraint:leftLayout];
    NSLayoutConstraint *rightLayout = [NSLayoutConstraint constraintWithItem:_placeholderLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0];
    [self addConstraint:rightLayout];
    NSLayoutConstraint *topLayout = [NSLayoutConstraint constraintWithItem:_placeholderLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:yOffset];
    [self addConstraint:topLayout];
    NSLayoutConstraint *heightLayout = [NSLayoutConstraint constraintWithItem:_placeholderLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:1.0f];
    [_placeholderLabel addConstraint:heightLayout];
}

-(void)setDelegate:(id<UITextViewDelegate>)delegate{
    [super setDelegate:self];
}

-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.font = [UIFont systemFontOfSize:16.0f];
        _placeholderLabel.userInteractionEnabled = NO;
        _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_placeholderLabel];
        [self updatePlaceholderLabelLayout];
    }
    return _placeholderLabel;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
}

-(void)setText:(NSString *)text{
    [super setText:text];
    if (text.length > 0) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
}

-(void)setTextContainerInset:(UIEdgeInsets)textContainerInset{
    [super setTextContainerInset:textContainerInset];
}

-(void)setContentInset:(UIEdgeInsets)contentInset{
    [super setContentInset:contentInset];
}

/**
 * 获取text能全部显示的最小高度
 * 注：该方法需在view显示后调用，否者可能不能返回正确的高度
 */
-(CGFloat)getMinHeightForView{
    NSString *inputString = self.text;
    if (!inputString ||
        inputString.length == 0 ||
        [inputString isKindOfClass:[NSNull class]]) {
        return 0;
    } else {
        CGSize size = [self sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
        return size.height;
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.xlDelegate textViewShouldBeginEditing:textView];
    } else {
       return YES;
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.xlDelegate textViewShouldEndEditing:textView];
    } else {
        return YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.xlDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.xlDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.xlDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    } else {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.xlDelegate textViewDidChange:textView];
    }
    
    CGFloat datHeight = 0;
    CGFloat height = [self getMinHeightForView];
    if (self.textViewHeight > 0) {
        datHeight = height - self.textViewHeight;
    }
    self.textViewHeight = height;
    if (fabs(datHeight) > 0.01) {
        if(self.xlDelegate && [self.xlDelegate respondsToSelector:@selector(textView:heightChange:)]){
            [self.xlDelegate textView:self heightChange:self.frame.size.height + datHeight];
        }
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.xlDelegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_ENUM_AVAILABLE_IOS(10_0){
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:interaction:)]) {
        return [self.xlDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange interaction:interaction];
    } else {
        return YES;
    }
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_ENUM_AVAILABLE_IOS(10_0){
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:interaction:)]) {
        return [self.xlDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange interaction:interaction];
    } else {
        return YES;
    }
}
#ifndef XLAvailableiOS10
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [self.xlDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    } else {
        return YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        return [self.xlDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    } else {
        return YES;
    }
}
#else

#endif

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.xlDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2){
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.xlDelegate scrollViewDidZoom:scrollView];
    }
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.xlDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.xlDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.xlDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.xlDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.xlDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.xlDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.xlDelegate viewForZoomingInScrollView:scrollView];
    } else {
        return nil;
    }
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2){
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.xlDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.xlDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.xlDelegate scrollViewShouldScrollToTop:scrollView];
    } else {
        return NO;
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.xlDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)){
    if (self.xlDelegate &&
        [self.xlDelegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.xlDelegate scrollViewDidChangeAdjustedContentInset:scrollView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
