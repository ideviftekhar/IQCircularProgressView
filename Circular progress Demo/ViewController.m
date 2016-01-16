//
//  ViewController.m
//  Circular progress Demo
//
//  Created by Iftekhar on 17/01/16.
//  Copyright © 2016 Iftekhar. All rights reserved.
//

#import "ViewController.h"
#import "IQCircularProgressView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet IQCircularProgressView *progressView;
@property (strong, nonatomic) IBOutlet UISwitch *switchAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.progressView.tintColor = [UIColor whiteColor];
//    self.progressView.state = IQProgressViewStateProgress;
}

- (IBAction)sliderTouchUp:(UISlider *)sender
{
    [self.progressView setProgress:sender.value animated:self.switchAnimation.on];
}

- (IBAction)stepperChanged:(UIStepper *)sender {
    [self.progressView setState:sender.value];
}


@end
