//
//  UIAlertViewDelegate.h
//  Marshmallows
//
//  Created by Sami Samhuri on 11-09-05.
//  Copyright 2011 Sami Samhuri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^UIAlertViewCallback)(int buttonClicked, BOOL canceled);

@interface UIAlertViewDelegate : NSObject <UIAlertViewDelegate>
{
    UIAlertViewCallback _callback;
}

+ (id) alertViewDelegateWithCallback: (UIAlertViewCallback)callback;
- (id) initWithCallback: (UIAlertViewCallback)callback;

@end
