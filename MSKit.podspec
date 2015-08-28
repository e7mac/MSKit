Pod::Spec.new do |s|
  s.name             = "MSKit"
  s.version          = "0.1.2"
  s.summary          = "A set of all the utility classes and extensions used in my iOS projects."
  s.license          = 'MIT'
  s.homepage           = 'http://www.e7mac.com'
  s.author           = { "e7mac" => "mayank.ot@gmail.com" }
  s.source           = { :git => "https://github.com/e7mac/MSKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/e7mac'

  s.platform     = :ios, '5.0'
  s.requires_arc = true

  s.source_files = 'Classes/*'
  # s.resources = 'Assets/**/*'

  s.dependency 'Fabric'  
  s.dependency 'Crashlytics'  
  s.dependency 'Mixpanel'
  s.dependency 'Amplitude-iOS'
  s.dependency 'Parse'
  #s.dependency 'Leanplum-iOS-SDK'
end
