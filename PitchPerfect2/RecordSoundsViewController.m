//
//  RecordSoundsViewController.m
//  PitchPerfect2
//
//  Created by Jeff Newell on 3/30/15.
//  Copyright (c) 2015 Jeff Newell. All rights reserved.
//

#import "RecordSoundsViewController.h"
#import "PlaySoundsViewController.h"

@interface RecordSoundsViewController ()

@end

@implementation RecordSoundsViewController


UIColor * cDFLT_RECORD_BTN_COLOR;
UIColor * cBLINK_RECORD_BTN_COLOR;
AVAudioRecorder * audioRecorder;
RecordedAudio * recordedAudio;
NSTimer * blinkTimer;
bool pauseMode;

-(void)viewWillAppear:(BOOL)animated{
    [_stopButton setHidden:YES];
    [_pauseButton setHidden:YES];
    [_recordButton setEnabled:YES];
    [_recordingStatusLabel setText:@"Tap to Record"];
    [_recordingStatusLabel setTextColor:cDFLT_RECORD_BTN_COLOR];
    pauseMode = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    cDFLT_RECORD_BTN_COLOR = _recordButton.backgroundColor;
    cBLINK_RECORD_BTN_COLOR = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordAudio:(UIButton *)sender {
    //UI State
    [_recordingStatusLabel setText:@"Recording Now"];
    [_recordButton setEnabled: NO];
    [_stopButton setHidden: NO];
    [_pauseButton setHidden: NO];
    [_pauseButton setEnabled:YES];
    if(blinkTimer != nil && blinkTimer.valid && pauseMode){
        [blinkTimer invalidate];
    }
    if(pauseMode){
        pauseMode = false;
        [_recordButton setBackgroundColor:cDFLT_RECORD_BTN_COLOR];
        //[_recordingStatusLabel setTextColor:cDFLT_STATUS_LBL_COLOR]; //TODO:
    }else{
        //recording actions
        NSString* docpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSDate* curDateTime = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"ddMMyyyy-HHmmss"];
        NSString* recordingName = [NSString stringWithFormat:@"%@%@", [formatter stringFromDate: curDateTime], @".wav"];
        NSArray* pathArray = [NSArray arrayWithObjects:docpath,recordingName, nil];
        NSURL* filePath = [NSURL fileURLWithPathComponents:pathArray];
        NSLog(@"%@", filePath);
    
        AVAudioSession * session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        audioRecorder = [[AVAudioRecorder alloc] initWithURL:filePath settings:nil error:nil];
        [audioRecorder setDelegate: self];
        [audioRecorder setMeteringEnabled:YES];
    }
    [audioRecorder record];
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if(flag){
        recordedAudio = [[RecordedAudio alloc] initWithUrl: recorder.url title: recorder.url.lastPathComponent];
        [self performSegueWithIdentifier:@"stopRecording" sender:recordedAudio];
        
    }else{
        NSLog(@"%@", @"warning: recording did not succesfully complete");
        [_recordButton setEnabled:YES];
        [_stopButton setHidden:YES];
        [_pauseButton setHidden:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if( [segue.identifier isEqualToString:@"stopRecording"]){
        PlaySoundsViewController* targetVC = segue.destinationViewController;
        targetVC.lastRecordedAudio = sender;
    }
    
}

-(void) resetIsRecordingLabel{
    [_recordingStatusLabel setTextColor: cDFLT_RECORD_BTN_COLOR];
    [_recordingStatusLabel setText: @"Tap to Record"];
}

- (IBAction)stopRecording:(UIButton *)sender {
    [self resetIsRecordingLabel];
    
    [audioRecorder stop];
    AVAudioSession* session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
}
-(void) blink {
    [_recordButton setBackgroundColor:(_recordButton.backgroundColor == cDFLT_RECORD_BTN_COLOR ? cBLINK_RECORD_BTN_COLOR: cDFLT_RECORD_BTN_COLOR)];
}
- (IBAction)pauseRecording:(UIButton *)sender {
    pauseMode=true;
    blinkTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(blink) userInfo:nil repeats:YES];
    [_recordButton setEnabled:YES];
    [_pauseButton setEnabled:NO];
    [_recordingStatusLabel setText: @"recording is paused"];
    [audioRecorder pause];
}
@end
