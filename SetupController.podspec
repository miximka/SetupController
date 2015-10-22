#
# Be sure to run `pod lib lint SetupController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SetupController"
  s.version          = "0.3.0"
  s.summary          = "MBSetupController can present a sequence of dialog views that lead the user through a series of steps like a wizard or a setup assistant."
  s.description      = <<-DESC
                       A MBSetupController is a subclass of UIViewController controller that acts like a wizard or setup assistant to present a sequence of dialog views that lead the user through a series of steps.

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/miximka/SetupController"
  #s.screenshots     = "https://www.dropbox.com/s/n41kjm8i4tlkkoc/iPhonePortrait.png?dl=1", "https://www.dropbox.com/s/wnpeol26nu9eja7/iPadLandscape.png?dl=1"
  s.license          = 'MIT'
  s.author           = { "Maksim Bauer" => "miximka@gmail.com" }
  s.source           = { :git => "https://github.com/miximka/SetupController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/miximka'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'SetupController' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
