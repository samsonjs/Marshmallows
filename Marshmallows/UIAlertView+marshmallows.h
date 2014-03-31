//
//  UIAlertView+marshmallows.h
//  DatingX
//
//  Created by Sami Samhuri on 11-08-24.
//  Copyright 2011 Sami Samhuri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAlertViewDelegate.h"

@interface UIAlertView (UIAlertView_marshmallows)

+ (void) showAlertWithTitle: (NSString *)title message: (NSString *)message;
+ (void) confirmWithTitle: (NSString *)title message: (NSString *)message then: (UIAlertViewCallback)callback;
+ (void) confirmWithTitle: (NSString *)title
                  message: (NSString *)message
              cancelTitle: (NSString *)cancelTitle
                  okTitle: (NSString *)okTitle
                     then: (UIAlertViewCallback)callback;

@end
