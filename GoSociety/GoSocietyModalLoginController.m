//
//  GoSocietyModalLoginController.m
//  GoSociety
//
//  Created by Praveen Reddy on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoSocietyModalLoginController.h"
#import "GoSocietyFBLoginController.h"
#import "GoSocietySignUpController.h"
#import "GoSocietyLoginController.h"

@implementation GoSocietyModalLoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) showFBView {
    
    GoSocietyFBLoginController *gsfb = [[GoSocietyFBLoginController alloc]init];
    [self.navigationController pushViewController:gsfb animated:YES];
    [gsfb release];
    
}

- (IBAction)fbCreateLoginPressed:(UIButton *) sender
{
    [self showFBView];
}

- (IBAction)signUpPressed:(UIButton *)sender
{
    GoSocietySignUpController *signup = [[GoSocietySignUpController alloc]init];
    
    [self.navigationController pushViewController:signup animated:YES];
    [signup release];
}

- (IBAction)loginPressed:(UIButton *)sender
{
    GoSocietyLoginController *login = [[GoSocietyLoginController alloc]init];
    
    [self.navigationController pushViewController:login animated:YES];
    [login release];
}

- (void)dealloc
{
    [super dealloc];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
