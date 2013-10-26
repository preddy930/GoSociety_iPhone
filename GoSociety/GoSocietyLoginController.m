//
//  GoSocietyLoginController.m
//  GoSociety
//
//  Created by Praveen Reddy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoSocietyLoginController.h"

@interface GoSocietyLoginController ()

@property (nonatomic,retain) IBOutlet UITextField   *login;
@property (nonatomic,retain) IBOutlet UITextField   *password;

@end


@implementation GoSocietyLoginController

@synthesize login;
@synthesize password;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [login setDelegate:self];
    [password setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.login = nil;
    self.password = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == login) {
        [password becomeFirstResponder];
    }
    
    if ( textField == password) {
        if ([login.text length]<=0){
            [login becomeFirstResponder];
        }
        
        else {
            if ([password.text length]>0) {
                [self textFieldDoneEditing:password];
            }
        }
    }
    
    return YES;
}

- (void)dealloc
{
    [super dealloc];
    [login release];
    [password release];
}

@end
