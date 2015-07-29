//
//  ViewController.m
//  D3RecordButtonDemo
//
//  Created by bmind on 15/7/28.
//  Copyright (c) 2015年 bmind. All rights reserved.
//

#import "ViewController.h"
#import "RecordHUD.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet D3RecordButton *btn;
@property (weak, nonatomic) IBOutlet D3RecordButton *centerBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_btn initRecord:self maxtime:10 title:@"上滑取消录音"];
    [_centerBtn initRecord:self maxtime:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)endRecord:(NSData *)voiceData{
    NSError *error;
    play = [[AVAudioPlayer alloc]initWithData:voiceData error:&error];
    NSLog(@"%@",error);
    play.volume = 1.0f;
    [play play];
    NSLog(@"yesssssssssss..........%f",play.duration);
    [_btn setTitle:@"按住录音" forState:UIControlStateNormal];
}

//不改btn的话这些就不要了
-(void)dragExit{
    [_btn setTitle:@"按住录音" forState:UIControlStateNormal];
}


-(void)dragEnter{
    [_btn setTitle:@"松开发送" forState:UIControlStateNormal];
}
@end
