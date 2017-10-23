#
# Be sure to run `pod lib lint SetupController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SetupController'
  s.version          = '0.4.0'
  s.summary          = 'MBSetupController can present a sequence of dialog views that lead the user through a series of steps like a wizard or a setup assistant.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A MBSetupController is a subclass of UIViewController controller that acts like a wizard or setup assistant to present a sequence of dialog views that lead the user through a series of steps.
                       DESC

  s.homepage         = 'https://github.com/miximka/SetupController'
  # s.screenshots      = 'Images/iPhonePortrait.png', 'Images/iPadLandscape.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Maksim Bauer' => 'miximka@gmail.com' }
  s.source           = { :git => 'https://github.com/miximka/SetupController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/miximka'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SetupController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SetupController' => ['SetupController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
