//
//  JMSMainWindow.h
//  IB Calisthenics
//
//  Created by Jared Sorge on 10/1/13.
//  Copyright (c) 2013 jsorge. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JMSMainWindow : NSWindow

#pragma mark - Top section
@property (weak) IBOutlet NSTextField *textFieldToCopy;
@property (weak) IBOutlet NSTextField *topTextLabel;

#pragma mark - Segmented Control
@property (weak) IBOutlet NSTextField *segmentedControlLabel;
@property (strong, nonatomic)NSArray *segmentedControlArray;
@property (weak) IBOutlet NSSegmentedControl *numberSegmentedControl;

#pragma mark - Seasons Box
@property (weak) IBOutlet NSTextField *seasonTextLabel;
@property (strong, nonatomic)NSDictionary *seasonDictionary;
@property (weak) IBOutlet NSMatrix *seasonsMatrix;

#pragma mark - Date
@property (weak) IBOutlet NSTextField *dateLabel;

#pragma mark - Square Section
@property (weak) IBOutlet NSTextField *squareFullTextLabel;
@property (weak) IBOutlet NSTextField *squareNumberLabel;
@property (weak) IBOutlet NSSlider *squareNumberSlider;
@property (weak) IBOutlet NSTextField *numberToSquareLabel;

#pragma mark - Speech
@property (weak) IBOutlet NSSegmentedControl *voicesToChoose;
@property (weak) IBOutlet NSTextField *textFieldToSpeak;
@property (weak) IBOutlet NSButton *shushButton;
@property (weak) IBOutlet NSSpeechSynthesizer *speechSynth;


- (IBAction)changeSegmentLabel:(id)sender;
- (IBAction)changeSeason:(id)sender;
- (IBAction)changeDateLabel:(id)sender;
- (IBAction)changeNumberToSquare:(id)sender;
- (IBAction)changeSpeechSynthVoice:(id)sender;
- (IBAction)changeSpeechSpeed:(id)sender;
- (IBAction)speakButton:(id)sender;
- (IBAction)stopSpeaking:(id)sender;

@end
