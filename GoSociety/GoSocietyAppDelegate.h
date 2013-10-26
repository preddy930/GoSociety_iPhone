//
//  GoSocietyAppDelegate.h
//  GoSociety
//
//  Created by Praveen Reddy on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class GoSocietyViewController;

@interface GoSocietyAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@end
