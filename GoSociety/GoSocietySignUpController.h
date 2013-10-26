//
//  GoSocietySignUpController.h
//  GoSociety
//
//  Created by Praveen Reddy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoSocietySignUpController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate> {
    
    IBOutlet UITextField   *fname;
    IBOutlet UITextField   *lname;
    IBOutlet UITextField   *login;
    IBOutlet UITextField   *password;
    IBOutlet UITextField   *gender;
    IBOutlet UITextField   *birthday;
}

- (void)textFieldDoneEditing:(id)sender;
- (void)configureGenderPicker;
- (void)configureBirthdayDatePicker;

@end
