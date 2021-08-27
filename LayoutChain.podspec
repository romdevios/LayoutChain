#
#  Be sure to run `pod spec lint LayoutChain.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "LayoutChain"
  spec.version      = "0.1.0"
  spec.summary      = "A Swift AutoLayout DSL for iOS"

  spec.description  = <<-DESC
LayoutChain has simple intuitive syntax and decreased compilation time of views layout setup. Easy access to creating single constraint and features to setup own UIStackView with a little amount of constraints.
The idea was to create lightweight wrapper on AutoLayout without lossing access to native API. Other frameworks may have a lot of generics and operators overload that can significantly increase the time for type-checking during compilation. Some frameworks has complex API to construct layout but even do not has simple functions to take a single constraint for its managing.
                   DESC

  spec.homepage     = "https://github.com/romdevios/LayoutChain"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Roman Filippov" => "roman.filippov.dev@gmail.com" }


  spec.platform     = :ios, "9.0"
  spec.swift_version = "5.2"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  spec.source       = { :git => "https://github.com/romdevios/LayoutChain.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/LayoutBuilder/**/*.{h,m,swift}"


end
