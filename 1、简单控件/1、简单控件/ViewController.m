//
//  ViewController.m
//  1、简单控件
//
//  Created by 贾则栋 on 15/12/25.
//  Copyright © 2015年 贾则栋. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;

@end

@implementation ViewController

//选择Did End On Exit事件，按下return按钮关闭键盘
- (IBAction)endEditName:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)endEditPassword:(id)sender {
    [sender resignFirstResponder];
}

//触摸背景关闭键盘
- (IBAction)backgroundTap:(id)sender {
    [self.name resignFirstResponder];
    [self.password resignFirstResponder];
}

//滑动条值改变后，其值在右边的标签中显示
- (IBAction)valueChanged:(UISlider *)sender {
    int progress = (int)lroundf(sender.value);
    self.sliderLabel.text = [NSString stringWithFormat:@"%d", progress];
}

//两个开关互相跟随状态改变
- (IBAction)leftSwitch:(UISwitch *)sender {
    BOOL setting = sender.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}

//分段控件的操作
- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.leftSwitch.hidden = NO;
        self.rightSwitch.hidden = NO;
    }
    else {
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
    }
}

//显示操作表单
- (IBAction)buttonPressed:(UIButton *)sender {
    //创建操作表单，标题下不显示消息，而是
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you Suer?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    /*类型：
     UIAlertControllerStyleAlert        警报（中间显示）
     UIAlertControllerStyleActionSheet  表单（底部显示）
     */
    
    //创建警告视图，默认不提供按钮
    //创建警告视图的yesAction按钮
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes, I'm sure!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *msg;
        NSLog(@"%@, %lu", self.name.text, [self.name.text length]);
        if ([self.name.text length] > 0) {
            msg = [NSString stringWithFormat:@"Your name is %@.", self.name.text];
        }
        else {
            msg = @"Please input your name!";
        }
        //新建警告视图
        UIAlertController *alertControl2 = [UIAlertController alertControllerWithTitle:@"Something was done" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Phew!" style:UIAlertActionStyleCancel handler:nil];
        [alertControl2 addAction:cancelAction];
        [self presentViewController:alertControl2 animated:YES completion:nil];
    }];
    //创建警告视图的noAction按钮
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No way!" style:UIAlertActionStyleCancel handler:nil];
    
    //将警告视图按钮加到操作表单
    [alertController addAction:yesAction];
    [alertController addAction:noAction];
    
//    //通过获取到警告控制器的悬浮展示控制器，并设置其属性来设定操作表单会出现的位置
//    UIPopoverPresentationController *ppc = alertController.popoverPresentationController;
//    if (ppc != nil) {
//        ppc.sourceView = sender;
//        ppc.sourceRect = sender.bounds;
//        ppc.permittedArrowDirections = UIPopoverArrowDirectionDown;
//    }
    
    //将警告控制器作为展示的控制器以显示操作表单
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
