//
//  RecordedAudio.h
//  PitchPerfect2
//
//  Created by Jeff Newell on 3/30/15.
//  Copyright (c) 2015 Jeff Newell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordedAudio : NSObject

@property NSURL* filePathUrl;
@property NSString* title;

-(instancetype)initWithUrl: (NSURL *)fileUrl title: (NSString *) theTitle;

@end
