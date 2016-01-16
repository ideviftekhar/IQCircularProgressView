//
//  IQCircularProgressView.h
// https://github.com/hackiftekhar/IQCircularProgressView
// Copyright (c) 2016 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, IQProgressViewState){
    IQProgressViewStateNone = 0,
    IQProgressViewStateSpinning,
    IQProgressViewStateProgress,
};


@interface IQCircularProgressView : UIView

/**
 State of the circular progress view.
 **/
@property (nonatomic, assign) IQProgressViewState state;

/**
 Progress of the view. It must be between 0 and 1.
 **/
@property (nonatomic, assign) CGFloat progress;

/**
 Set progress with animation
 **/
- (void)setProgress:(float)progress animated:(BOOL)animated;

/**
 Tint color is used to render progress color
 */
@property (nonatomic, strong) UIColor *tintColor;


@end
