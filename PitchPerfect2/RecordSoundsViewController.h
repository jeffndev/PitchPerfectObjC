//
//  RecordSoundsViewController.h
//  PitchPerfect2
//
//  Created by Jeff Newell on 3/30/15.
//  Copyright (c) 2015 Jeff Newell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RecordedAudio.h"

@interface RecordSoundsViewController : UIViewController <AVAudioRecorderDelegate>
@property (weak, nonatomic) IBOutlet UILabel *recordingStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;


- (IBAction)recordAudio:(UIButton *)sender;
- (IBAction)stopRecording:(UIButton *)sender;
- (IBAction)pauseRecording:(UIButton *)sender;

@end


