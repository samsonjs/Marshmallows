Pod::Spec.new do |s|
  s.name                = "Marshmallows"
  s.version             = "0.1.2"
  s.summary             = "Marshmallows sweeten up your Cocoa for iOS."
  s.description         = <<-DESC
                          Sometimes the simple things are verbose with Cocoa. This project aims
                          to make the simple things less verbose. Mainly via categories, but this
                          may change. Or prefixes to each method name might be added.

                          **HTTP**

                          - Provides a simple HTTP client (built on top of a simple request class)

                          **NSDate**

                          - Adds `+[NSDate dateWithYear:month:day:]` to construct a date
                          - Adds `-[NSDate relativeToNow]` to get a string describing the date, e.g. 1 minute ago

                          **NSString**

                          - Adds `-[NSString firstMatch:]` to find the first substring matching the given regex string.
                          - Adds `-[NSString stringByReplacing:with:]` to replace all occurrences of the given regex string with something.
                          - Adds `-[NSString stringByReplacingFirst:with:]` to replace one occurrence of the given regex string with something.
                          - Adds `-[NSString stringByTrimmingWhitespace]` to trim strings.
                          - Adds `-[NSString stringByURLEncoding]` encodes a string for use in a URL, including ampersands (and others).

                          **UIAlertView**

                          The last argument to the confirm methods is a block with the signature `^(int buttonClicked, BOOL canceled)`.

                          - Adds `+[UIAlertView showAlertWithTitle:message:]`.
                          - Adds `+[UIAlertView confirmWithTitle:message:then:]`.
                          - Adds `+[UIAlertView confirmWithTitle:message:cancelTitle:okTitle:then:]`.
                        DESC
  s.homepage            = "http://github.com/samsonjs/Marshmallows"
  s.license             = "MIT"
  s.author              = { "Sami Samhuri" => "sami@samhuri.net" }
  s.social_media_url    = "https://twitter.com/_sjs"
  s.platform            = :ios, "5.0"
  s.source              = { :git => "https://github.com/samsonjs/Marshmallows.git", :tag => "0.1.2" }
  s.source_files        = "Marshmallows"
  s.public_header_files = "Marshmallows/**/*.h"
  s.requires_arc        = false
end
