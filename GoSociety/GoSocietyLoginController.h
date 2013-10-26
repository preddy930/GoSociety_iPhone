//
//  GoSocietyLoginController.h
//  GoSociety
//
//  Created by Praveen Reddy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GoSocietyLoginController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField   *login;
    IBOutlet UITextField   *password;
}


- (IBAction)textFieldDoneEditing:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
