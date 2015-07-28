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
    self.delegate = delegate;
    maxTime = _maxTime;
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
    NSLog(@"show hud");
}

//正常停止录音，开始转换数据
-(void)stopRecord{
    [mp3 stopRecord];
}

//取消录音
-(void)cancelRecord{
    [mp3 cancelRecord];
    NSLog(@"show hud cancel");
}

//离开按钮范围
- (void)RemindDragExit:(UIButton *)button
{
    NSLog(@"Release to cancel");
    if ([_delegate respondsToSelector:@selector(dragExit)]) {
        [_delegate dragExit];
    }
}

//进入按钮范围
- (void)RemindDragEnter:(UIButton *)button
{
    NSLog(@"Slide up to cancel");
    if ([_delegate respondsToSelector:@selector(dragEnter)]) {
        [_delegate dragEnter];
    }
}


#pragma mark Mp3RecordDelegate
-(void)beginConvert{
//    NSLog(@"begin");
}

//录音失败
- (void)failRecord
{
//    if (recordTime < 1) {
//        NSLog(@"show hud record toshort");
//    }
//    else{
//        NSLog(@"show hud record fail");
//    }
}


//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    NSLog(@"show hud suc");
    if ([_delegate respondsToSelector:@selector(endRecord:)]) {
        [_delegate endRecord:voiceData];
    }
}

-(void)recording:(int)recordTime volume:(float)volume{
    if (recordTime>=maxTime) {
        [self stopRecord];
    }
    NSLog(@"时间:%d, 声量:%f",recordTime,volume);

}
@end
