//
//  ViewController.m
//  D3RecordButtonDemo
//
//  Created by bmind on 15/7/28.
//  Copyright (c) 2015年 bmind. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet D3RecordButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_btn initRecord:self maxtime:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)recording:(int)second{
    NSLog(@"%d秒",second);
}

-(void)endRecord:(NSData *)voiceData{
    NSLog(@"yesssssssssss");
}


@end
