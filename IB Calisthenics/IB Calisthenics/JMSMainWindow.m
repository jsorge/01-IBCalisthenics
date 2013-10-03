//
//  JMSMainWindow.m
//  IB Calisthenics
//
//  Created by Jared Sorge on 10/1/13.
//  Copyright (c) 2013 jsorge. All rights reserved.
//

#import "JMSMainWindow.h"

@interface JMSMainWindow ()

@property (weak) IBOutlet NSSpeechSynthesizer *speechSynth;

#pragma mark - Top section
@property (weak) IBOutlet NSTextField *textFieldToCopy;
@property (weak) IBOutlet NSTextField *topTextLabel;

#pragma mark - Segmented Control
@property (weak) IBOutlet NSTextField *segmentedControlLabel;
@property (strong, nonatomic)NSArray *segmentedControlArray;

#pragma mark - Seasons Box
@property (weak) IBOutlet NSTextField *seasonTextLabel;

#pragma mark - Date
@property (weak) IBOutlet NSTextField *dateLabel;

#pragma mark - Square Section
@property (weak) IBOutlet NSTextField *squareFullTextLabel;
@property (weak) IBOutlet NSTextField *squareNumberLabel;
@property (weak) IBOutlet NSSlider *squareNumberSlider;
@property (weak) IBOutlet NSTextField *numberToSquareLabel;

#pragma mark - Speech
@property (strong, nonatomic)NSDictionary *voicesDictionary;
@property (weak) IBOutlet NSSegmentedControl *voicesToChoose;
@property (weak) IBOutlet NSTextField *textFieldToSpeak;
@property (weak) IBOutlet NSButton *shushButton;

@end

@implementation JMSMainWindow

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self changeSpeechSynthVoice:[self voicesToChoose]];
}

#pragma mark - Properties
- (NSArray *)segmentedControlArray
{
    if (!_segmentedControlArray) {
        _segmentedControlArray = @[@"0: Zero", @"1: One", @"2: Two"];
    }
    return _segmentedControlArray;
}

- (NSDictionary *)voicesDictionary
{
    if (!_voicesDictionary) {
        _voicesDictionary = @{@"Alex":@"com.apple.speech.synthesis.voice.Alex", @"Victoria":@"com.apple.speech.synthesis.voice.Victoria", @"Cellos":@"com.apple.speech.synthesis.voice.Cellos", @"Trinoids":@"com.apple.speech.synthesis.voice.Trinoids"};
    }
    return _voicesDictionary;
}

#pragma mark - Hello/Goodbye/Copy Buttons
- (IBAction)helloButton:(id)sender
{
    [[self topTextLabel] setStringValue: @"Hello world"];
}

- (IBAction)goodbyeButton:(id)sender
{
    [[self topTextLabel] setStringValue: @"Goodbye"];
}

- (IBAction)copyButton:(id)sender
{
    NSString *copyText = [[self textFieldToCopy] stringValue];
    [[self topTextLabel] setStringValue:copyText];
}

#pragma mark - Segmented Control
- (IBAction)changeSegmentLabel:(id)sender
{
    if ([sender isKindOfClass:[NSSegmentedControl class]]) {
        NSSegmentedControl *segmentedControl = sender;
        NSInteger segment = [segmentedControl selectedSegment];
        [[self segmentedControlLabel] setStringValue:[[self segmentedControlArray] objectAtIndex:segment]];
    }
}

#pragma mark - Seasons Box
- (IBAction)changeSeason:(id)sender
{
    if ([sender isKindOfClass:[NSMatrix class]]) {
        NSMatrix *seasonMatrix = sender;
        [[self seasonTextLabel] setStringValue:[[seasonMatrix selectedCell] title]];
    }
}

#pragma mark - Date
- (IBAction)changeDateLabel:(id)sender
{
    [[self dateLabel] setObjectValue:[NSDate date]];
}


#pragma mark - Square Section
- (IBAction)changeNumberToSquare:(id)sender
{
    NSNumber *sliderValue = [NSNumber numberWithFloat:[[self squareNumberSlider] floatValue]];
    [[self numberToSquareLabel] setObjectValue:sliderValue];
    sliderValue = [NSNumber numberWithFloat:([sliderValue floatValue] * [sliderValue floatValue])];
    [[self squareNumberLabel] setObjectValue:sliderValue];
    [[self squareFullTextLabel] setObjectValue:sliderValue];
}

#pragma mark - Speech
- (IBAction)changeSpeechSynthVoice:(id)sender
{
    if ([sender isKindOfClass:[NSSegmentedControl class]]) {
        NSSegmentedControl *voices = sender;
        NSString *voice = [voices labelForSegment:[voices selectedSegment]];
        NSString *voiceName = [[self voicesDictionary] objectForKey:voice];
        [[self speechSynth] setVoice:voiceName];
    }
}

- (IBAction)changeSpeechSpeed:(id)sender
{
    if ([sender isKindOfClass:[NSSlider class]]) {
        NSSlider *speedSlider = sender;
        CGFloat wordsPerSecond = [speedSlider floatValue];
        [[self speechSynth] setRate:wordsPerSecond];
    }
}

- (IBAction)speakButton:(id)sender
{
    [[self speechSynth] startSpeakingString:[[self textFieldToSpeak] stringValue]];
    [[self shushButton] setEnabled:YES];
}

- (IBAction)stopSpeaking:(id)sender
{
    [[self speechSynth] stopSpeaking];
    [[self shushButton] setEnabled:NO];
}

@end
