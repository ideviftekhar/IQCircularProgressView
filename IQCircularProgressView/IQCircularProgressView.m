//
//  IQCircularProgressView.m
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

#import "IQCircularProgressView.h"

NSString * const IQCircularProgressAnimationKey = @"IQCircularProgressAnimationKey";
NSString * const IQCircularProgressIndeterminantAnimationKey = @"IQCircularProgressIndeterminantAnimationKey";

CGFloat const IQCircularIndeterminantProgressValue = 0.25;

@interface IQCircularProgressView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end


@implementation IQCircularProgressView

@dynamic tintColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    
    UIColor *tintColor = nil;
    
    if(self.tintColor)
    {
        tintColor = self.tintColor;
    }
    else
    {
        tintColor = [UIColor colorWithRed:0 green:122/255.0 blue:1.0 alpha:1];
    }

    _progressLayer.strokeColor = [tintColor CGColor];
    _progressLayer.borderColor = [[tintColor colorWithAlphaComponent:0.5] CGColor];
}

- (void)setup
{
    self.hidden = YES;
    self.userInteractionEnabled = NO;
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.contentsScale = [[UIScreen mainScreen] scale];
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapSquare;
    _progressLayer.lineWidth = 2.0;
    [self.layer addSublayer:_progressLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.25;
    [_progressLayer addAnimation:animation forKey:IQCircularProgressAnimationKey];

    [self tintColorDidChange];
}

- (void)dealloc {
}

-(void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    _progressLayer.frame = self.layer.bounds;
    _progressLayer.cornerRadius = _progressLayer.frame.size.width/2.0f;
    _progressLayer.path = [self progressPath].CGPath;
}

- (UIBezierPath *)progressPath
{
    const double TWO_M_PI = 2.0 * M_PI;
    const double startAngle = 0.75 * TWO_M_PI;
    const double endAngle = startAngle + TWO_M_PI;
    
    CGFloat width = self.frame.size.width;
    CGFloat lineWidth = _progressLayer.lineWidth;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0f, width/2.0f)
                                          radius:width/2.0f - lineWidth/2.0f
                                      startAngle:startAngle
                                        endAngle:endAngle
                                       clockwise:YES];
}

#pragma mark Setters

-(void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}

-(void)setProgress:(float)progress animated:(BOOL)animated
{
    //Keeping progress between 0 and 1
    progress = MAX(0.0, progress);
    progress = MIN(1.0, progress);
    
    if (_progress != progress)
    {
        if (_state == IQProgressViewStateProgress)
        {
            _progressLayer.strokeEnd = progress;
        }

        _progress = progress;
    }
}

-(void)setState:(IQProgressViewState)state
{
    if (_state != state)
    {
        [_progressLayer removeAllAnimations];

        switch (state)
        {
            case IQProgressViewStateNone:
            {
                self.hidden = YES;
            }
                break;
                
            case IQProgressViewStateProgress:
            {
                self.hidden = NO;
                
                _progressLayer.strokeEnd = _progress;
                _progressLayer.borderWidth = 1.0;
            }
                break;
                
            case IQProgressViewStateSpinning:
            {
                self.hidden = NO;

                _progressLayer.strokeEnd = IQCircularIndeterminantProgressValue;
                _progressLayer.borderWidth = 0.0;
                
                CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
                spinAnimation.toValue        = @(1*2*M_PI);
                spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                spinAnimation.duration       = 1.0;
                spinAnimation.repeatCount    = INFINITY;
                [_progressLayer addAnimation:spinAnimation forKey:IQCircularProgressIndeterminantAnimationKey];
            }
                break;
        }

        _state = state;
    }
}

@end
