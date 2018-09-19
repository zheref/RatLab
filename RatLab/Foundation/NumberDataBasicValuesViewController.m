//
//  NumberDataBasicValuesViewController.m
//  RatLab
//
//  Created by Sergio Lozano García on 9/19/18.
//  Copyright © 2018 Sergio Lozano García. All rights reserved.
//

#import "NumberDataBasicValuesViewController.h"

@interface NumberDataBasicValuesViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputValueTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *parseTypePickerView;
@property (weak, nonatomic) IBOutlet UITextView *interpretationOutputTextView;

@property (strong, nonatomic) NSArray *typesArray;

@end

@implementation NumberDataBasicValuesViewController

NSString *const CHAR_TYPE_STR = @"char"; // 8 bit
NSString *const INT_TYPE_STR = @"int"; // 32 or 64 bit (depending of OS)
NSString *const FLOAT_TYPE_STR = @"float";
NSString *const DOUBLE_TYPE_STR = @"double";
NSString *const STRING_TYPE_STR = @"string";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *stringClassStr = NSStringFromClass(NSString.class);
    
    self.typesArray = [[NSArray alloc] initWithObjects:CHAR_TYPE_STR, INT_TYPE_STR, FLOAT_TYPE_STR, DOUBLE_TYPE_STR, STRING_TYPE_STR, stringClassStr, nil];
    
    [self.inputValueTextField addTarget:self action:@selector(inputValueTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.parseTypePickerView setDelegate:self];
    [self.parseTypePickerView setDataSource:self];
    [self.inputValueTextField setDelegate:self];
}

- (void)inputValueTextFieldDidChange {
    [self process];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.typesArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *typeStringForRow = (NSString*) [self.typesArray objectAtIndex:row];
    return typeStringForRow;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self process];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self process];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.inputValueTextField resignFirstResponder];
    return YES;
}

- (void)process {
    NSInteger currentSelectionIndex = [self.parseTypePickerView selectedRowInComponent:0];
    NSString *currentSelection = [self.typesArray objectAtIndex:currentSelectionIndex];
    NSString *inputValue = [self.inputValueTextField text];
    
    if ([inputValue length] == 0) {
        [self display:@"No input data"];
    } else if (currentSelection == CHAR_TYPE_STR) {
        char castedValue = [inputValue characterAtIndex:0];
        NSString *formattedValue = [[NSString alloc] initWithFormat:@"%c", castedValue];
        [self display:formattedValue];
    } else if (currentSelection == INT_TYPE_STR) {
        int castedValue = [inputValue intValue];
        NSString *formattedValue = [[NSString alloc] initWithFormat:@"%d", castedValue];
        [self display:formattedValue];
    } else if (currentSelection == FLOAT_TYPE_STR) {
        float castedValue = [inputValue floatValue];
        NSString *formattedValue = [[NSString alloc] initWithFormat:@"%f\n%e", castedValue, castedValue];
        [self display:formattedValue];
    } else if (currentSelection == DOUBLE_TYPE_STR) {
        double castedValue = [inputValue doubleValue];
        NSString *formattedValue = [[NSString alloc] initWithFormat:@"%f\n%e", castedValue, castedValue];
        [self display:formattedValue];
    }
}

- (void)display:(NSString *)objectStr {
    [self.interpretationOutputTextView setText:objectStr];
}

@end
