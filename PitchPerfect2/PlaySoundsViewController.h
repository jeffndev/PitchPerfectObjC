//
//  PlaySoundsViewController.h
//  PitchPerfect2
//
//  Created by Jeff Newell on 3/30/15.
//  Copyright (c) 2015 Jeff Newell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlaySoundsViewController : UIViewController

@property RecordedAudio* lastRecordedAudio;

- (IBAction)playFast:(UIButton *)sender;

- (IBAction)stopPlayback:(UIButton *)sender;

@end
