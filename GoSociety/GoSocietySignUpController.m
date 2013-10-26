//
//  GoSocietySignUpController.m
//  GoSociety
//
//  Created by Praveen Reddy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoSocietySignUpController.h"

@interface GoSocietySignUpController ()

@property (nonatomic,retain) IBOutlet UITextField   *fname;
@property (nonatomic,retain) IBOutlet UITextField   *lname;
@property (nonatomic,retain) IBOutlet UITextField   *login;
@property (nonatomic,retain) IBOutlet UITextField   *password;
@property (nonatomic,retain) IBOutlet UITextField   *gender;
@property (nonatomic,retain) IBOutlet UITextField   *birthday;

@property (nonatomic) CGFloat animatedDistance;

@end

@implementation GoSocietySignUpController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 1.0;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@synthesize fname;
@synthesize lname;
@synthesize login;
@synthesize password;
@synthesize gender;
@synthesize birthday;

@synthesize animatedDistance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    //Code for auto scrolling the text fields
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
    if (textField == gender)
        [self configureGenderPicker];
    
    if (textField == birthday)
        [self configureBirthdayDatePicker];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == fname){
        [lname becomeFirstResponder];
    }
    
    else if (textField == lname){
        [login becomeFirstResponder];
    }
    
    else if (textField == login){
        [password becomeFirstResponder];
    }
    
    else if (textField == password){
        [birthday becomeFirstResponder];
    }
    
    else if (textField == birthday){
        [gender becomeFirstResponder];
    }
    
    else if (textField == gender) {
        [gender resignFirstResponder];
    }
    
    if ([fname.text length]>0 && [textField.text length]>0 && [login.text length]>0 
        && [password.text length]>0 && [gender.text length]>0) {
        
    }
    
    return YES;
}

- (void)configureGenderPicker {
    
    UIPickerView *genderPicker = [[UIPickerView alloc] init];
    
    genderPicker.delegate = self;
    genderPicker.showsSelectionIndicator = YES;
    
    gender.inputView = genderPicker;
    
    if ([gender.text length]==0) {
        gender.text = @"Boy";
    }
    
    else {
        if ([gender.text isEqualToString:@"Girl"]) {
            [genderPicker selectRow:1 inComponent:0 animated:NO];
        }
        
        else if ([gender.text isEqualToString:@"Decline"]) {
            [genderPicker selectRow:2 inComponent:0 animated:NO];
        }
    }
    
    [genderPicker release];
}

- (void)configureBirthdayDatePicker {
    
    UIDatePicker *bdayPicker = [[UIDatePicker alloc] init];

    bdayPicker.datePickerMode = UIDatePickerModeDate;
    bdayPicker.hidden = NO;
    birthday.inputView = bdayPicker;
    NSDate *date = [NSDate date];
    bdayPicker.maximumDate = date;
    
    if ([birthday.text length]>0) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSDate *date = [dateFormatter dateFromString:birthday.text];
        [bdayPicker setDate:date animated:NO];
        
        [dateFormatter release];
    }
    
    
    [bdayPicker addTarget:self action:@selector(changedBirthdayDate:) forControlEvents:UIControlEventValueChanged];
    
    [bdayPicker release];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [login setDelegate:self];
    [password setDelegate:self];
    [lname setDelegate:self];
    [fname setDelegate:self];
    [birthday setDelegate:self];
    [gender setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    login=nil;
    password=nil;
    lname=nil;
    fname=nil;
    birthday=nil;
    gender=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UIPickerDelegate methods (Gender selection)

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (row == 0) {
        gender.text = @"Boy";
    }
    
    else if (row == 1) {
        gender.text = @"Girl";
    }
    
    else if (row == 2) {
        gender.text = @"Decline";
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numRows = 3;
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    
    if (row == 0){
        title = [@"" stringByAppendingString:@"Boy"];
    }
    
    else if (row == 1){
        title = [@"" stringByAppendingString:@"Girl"];
    }
    
    else if (row == 2){
        title = [@"" stringByAppendingString:@"Decline"];
    }
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

- (void)changedBirthdayDate:(UIDatePicker *) picker{
    
	//Use NSDateFormatter to write out the date in a friendly format
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    birthday.text = [dateFormatter stringFromDate:picker.date];    
    
    [dateFormatter release];
}

@end
