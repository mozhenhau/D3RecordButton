//
//  D3RecordButton.m
//  D3RecordButtonDemo
//
//  Created by bmind on 15/7/28.
//  Copyright (c) 2015年 bmind. All rights reserved.
//

#import "D3RecordButton.h"

@implementation D3RecordButton

-(void)initRecord:(id<D3RecordDelegate>)delegate maxtime:(int)_maxTime{
    self.delegata = delegate;
    maxTime = _maxTime;
    recordTime = 0;
    mp3 = [[Mp3Recorder alloc]initWithDelegate:self];
    
    [self addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(cancelRecord) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [self addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
}

//开始录音
-(void)startRecord{
    [mp3 startRecord];
    recordTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    
    NSLog(@"show hud");
}

//正常停止录音，开始转换数据
-(void)stopRecord{
    if (playTimer) {
        [mp3 stopRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
}

//取消录音
-(void)cancelRecord{
    if (playTimer) {
        [mp3 cancelRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
    NSLog(@"show hud cancel");
}

//离开按钮范围
- (void)RemindDragExit:(UIButton *)button
{
    NSLog(@"Release to cancel");
    if ([_delegata respondsToSelector:@selector(dragExit)]) {
        [_delegata dragExit];
    }
}

//进入按钮范围
- (void)RemindDragEnter:(UIButton *)button
{
    NSLog(@"Slide up to cancel");
    if ([_delegata respondsToSelector:@selector(dragEnter)]) {
        [_delegata dragEnter];
    }
}

//录音计时
- (void)countVoiceTime
{
    recordTime ++;
    if ([_delegata respondsToSelector:@selector(recording:)]) {
        [_delegata recording:recordTime];
    }
    if (recordTime>=maxTime) {
        [self stopRecord];
    }
}


#pragma mark Mp3RecordDelegate
-(void)beginConvert{
//    NSLog(@"begin");
}

//录音失败
- (void)failRecord
{
    if (recordTime < 1) {
        NSLog(@"show hud record toshort");
    }
    else{
        NSLog(@"show hud record fail");
    }
}


//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    NSLog(@"show hud suc");
    if ([_delegata respondsToSelector:@selector(endRecord:)]) {
        [_delegata endRecord:voiceData];
    }
}

@end
