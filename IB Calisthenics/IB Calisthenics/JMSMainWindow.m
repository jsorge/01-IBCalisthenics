//
//  JMSMainWindow.m
//  IB Calisthenics
//
//  Created by Jared Sorge on 10/1/13.
//  Copyright (c) 2013 jsorge. All rights reserved.
//

#import "JMSMainWindow.h"

@implementation JMSMainWindow

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self changeSpeechSynthVoice:[self voicesToChoose]];
    [self changeNumberToSquare:[self squareNumberSlider]];
    [self changeSeason:[self seasonsMatrix]];
    [self changeSegmentLabel:[self numberSegmentedControl]];
}

#pragma mark - Properties
- (NSArray *)segmentedControlArray
{
    if (!_segmentedControlArray) {
        _segmentedControlArray = @[@"0: Zero", @"1: One", @"2: Two"];
    }
    return _segmentedControlArray;
}

- (NSDictionary *)seasonDictionary
{
    if (!_seasonDictionary) {
        _seasonDictionary = @{@"Winter": @"December", @"Spring":@"March", @"Summer":@"June", @"Fall":@"September"};
    }
    return _seasonDictionary;
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
- (IBAction)changeSegmentLabel:(NSSegmentedControl *)sender
{
    NSInteger segment = [sender selectedSegment];
    [[self segmentedControlLabel] setStringValue:[[self segmentedControlArray] objectAtIndex:segment]];
}

#pragma mark - Seasons Box
- (IBAction)changeSeason:(NSMatrix *)sender
{
    NSString *season = [[sender selectedCell] title];
    NSString *firstMonthOfSeason = [[self seasonDictionary] objectForKey:season];
    [[self seasonTextLabel] setStringValue:firstMonthOfSeason];
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
    
    NSNumber *sliderSquared = [NSNumber numberWithFloat:([sliderValue floatValue] * [sliderValue floatValue])];
    
    [[self squareNumberLabel] setObjectValue:sliderSquared];
    [[self squareFullTextLabel] setObjectValue:sliderSquared];
}

#pragma mark - Speech
- (IBAction)changeSpeechSynthVoice:(NSSegmentedControl *)sender
{
    NSString *voice = [sender labelForSegment:[sender selectedSegment]];
    NSString *voiceName = [NSString stringWithFormat:@"com.apple.speech.synthesis.voice.%@", voice];
    
    [[self speechSynth] setVoice:voiceName];
}

- (IBAction)changeSpeechSpeed:(NSSlider *)sender
{
    CGFloat wordsPerSecond = [sender floatValue];
    [[self speechSynth] setRate:wordsPerSecond];
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
