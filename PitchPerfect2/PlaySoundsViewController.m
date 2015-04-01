//
//  PlaySoundsViewController.m
//  PitchPerfect2
//
//  Created by Jeff Newell on 3/30/15.
//  Copyright (c) 2015 Jeff Newell. All rights reserved.
//

#import "RecordedAudio.h"
#import "PlaySoundsViewController.h"

@interface PlaySoundsViewController ()

@end

@implementation PlaySoundsViewController

AVAudioPlayer * player;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    player = [[AVAudioPlayer alloc] initWithContentsOfURL: _lastRecordedAudio.filePathUrl error: nil];
}
-(void)viewWillAppear:(BOOL)animated{
    
}
- (IBAction)toggleEffects:(UISegmentedControl *)sender {
    //TODO: if this is pressed during playback,
    //      restart the playback in the effect mode..
    //      OR, maybe this is where the effect needs
    //      to be set...
    NSLog(@"Selected segment index changed, it is now: %d",[sender selectedSegmentIndex]);
    
}

- (IBAction)playFast:(UIButton *)sender {
    [self playAtSpeed:1.0 doRestart:YES];
}

- (IBAction)stopPlayback:(UIButton *)sender {
    [player stop];
}

-(void) playAtSpeed: (float)theRate doRestart: (BOOL)restart{
    [player setEnableRate:YES];
    [player setRate:theRate];
    [player play];
}

@end
