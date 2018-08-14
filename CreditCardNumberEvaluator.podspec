#
#  Be sure to run `pod spec lint CreditCardNumberEvaluator.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "CreditCardNumberEvaluator"
  s.version      = "0.1.0"
  s.summary      = "Simple Credit Card Number Evaluator"
  s.description  = <<-DESC
  Simple Framework for the validating a number of the credit card and check the brand the number belongs to. iOS
                   DESC

  s.homepage     = "http://EXAMPLE/CreditCardNumberEvaluator"
  s.license      = "MIT"
  s.author             = { "Pavel" => "pavel.antonov1980@icloud.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "http://EXAMPLE/CreditCardNumberEvaluator.git", :tag => "#{s.version}" }
  s.source_files  = "**/*.{swift,h,m}"
  s.public_header_files = "**/*.h"

end
