//
//  UIAlertView+simple.m
//  DatingX
//
//  Created by Sami Samhuri on 11-08-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+simple.h"
#import "UIAlertViewDelegate.h"

@implementation UIAlertView (UIAlertView_simple)

+ (void) showAlertWithTitle: (NSString *)title message: (NSString *)message
{
    [[[[self alloc] initWithTitle: title
                          message: message
                         delegate: nil
                cancelButtonTitle: @"OK"
                otherButtonTitles: nil] autorelease] show];
}

+ (void) confirmWithTitle: (NSString *)title message: (NSString *)message then: (UIAlertViewCallback)callback
{
    [[[[self alloc] initWithTitle: title
                          message: message
                         delegate: [UIAlertViewDelegate alertViewDelegateWithCallback: callback]
                cancelButtonTitle: @"Cancel"
                otherButtonTitles: @"OK", nil] autorelease] show];
}

@end
