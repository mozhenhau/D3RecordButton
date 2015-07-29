# D3RecordButton
D3RecordButton, a easy way to record

##简介
封装了按按钮开始录音，有时间限制，手势离开按钮时松开可取消


##使用
1.`[btn initRecord:self maxtime:10 title:@"上滑取消录音"];`  

2.实现代理`-(void)endRecord:(NSData *)voiceData`
