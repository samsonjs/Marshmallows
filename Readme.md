# Marshmallows

Marshmallows sweeten up your Cocoa for iOS.


## Overview

Sometimes the simple things are verbose with Cocoa. This project aims
to make the simple things less verbose. Mainly via categories, but this
may change. Or prefixes to each method name might be added.


## Installation

Marshmallows is available on CocoaPods, add `pod 'Marshmallows', '~> 0.1'` to your Podfile.

Alternatively you could clone this repo and add the files you want into your project directly.


## Categories

### NSDate

- Adds `+[NSDate dateWithYear:month:day:]` to construct a date
- Adds `-[NSDate relativeToNow]` to get a string describing the date, e.g. 1 minute ago

### NSString

- Adds `-[NSString firstMatch:]` to find the first substring matching the given regex string.
- Adds `-[NSString stringByReplacing:with:]` to replace all occurrences of the given regex string with something.
- Adds `-[NSString stringByReplacingFirst:with:]` to replace one occurrence of the given regex string with something.
- Adds `-[NSString stringByTrimmingWhitespace]` to trim strings.
- Adds `-[NSString stringByURLEncoding]` encodes a string for use in a URL, including ampersands (and others).

### UIAlertView

The last argument to the confirm methods is a block with the signature `^(int buttonClicked, BOOL canceled)`.

- Adds `+[UIAlertView showAlertWithTitle:message:]`.
- Adds `+[UIAlertView confirmWithTitle:message:then:]`.
- Adds `+[UIAlertView confirmWithTitle:message:cancelTitle:okTitle:then:]`.


## Classes

### MMHTTPClient

Provides a simple HTTP client built on `MMHTTPRequest`. Makes it trivial to fetch some text or an image.
(JSON is coming!)


### MMHTTPRequest

A simple HTTP request class that uses blocks. It can decode text and image responses. (JSON is coming!)


# License

&copy; 2011-2014 Sami Samhuri <sami@samhuri.net>

[MIT license](http://sjs.mit-license.org)
