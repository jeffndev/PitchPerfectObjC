//
//  RecordedAudio.m
//  PitchPerfect2
//
//  Created by Jeff Newell on 3/30/15.
//  Copyright (c) 2015 Jeff Newell. All rights reserved.
//

#import "RecordedAudio.h"

@implementation RecordedAudio

-(instancetype)initWithUrl: (NSURL *)fileUrl title: (NSString *) theTitle {
    self = [super init];
    if(self){
        _filePathUrl = fileUrl;
        _title = theTitle;
    }
    return self;
}

@end
