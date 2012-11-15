//
//  UIAlertView+marshmallows.m
//  DatingX
//
//  Created by Sami Samhuri on 11-08-24.
//  Copyright 2011 Guru Logic. All rights reserved.
//

#import "UIAlertView+marshmallows.h"
#import "UIAlertViewDelegate.h"

@implementation UIAlertView (UIAlertView_marshmallows)

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
    [self confirmWithTitle: title message: message cancelTitle: @"Cancel" okTitle: @"OK" then: callback];
}

+ (void) confirmWithTitle: (NSString *)title
                  message: (NSString *)message
              cancelTitle: (NSString *)cancelTitle
                  okTitle: (NSString *)okTitle
                     then: (UIAlertViewCallback)callback
{
    [[[[self alloc] initWithTitle: title
                          message: message
                         delegate: [UIAlertViewDelegate alertViewDelegateWithCallback: callback]
                cancelButtonTitle: cancelTitle
                otherButtonTitles: okTitle, nil] autorelease] show];
}

@end
