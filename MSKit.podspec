Pod::Spec.new do |s|
  s.name             = "MSKit"
  s.version          = "0.2"
  s.summary          = "A set of all the utility classes and extensions used in my iOS projects."
  s.license          = 'MIT'
  s.homepage           = 'http://www.e7mac.com'
  s.author           = { "e7mac" => "mayank.ot@gmail.com" }
  s.source           = { :git => "https://github.com/e7mac/MSKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/e7mac'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  subspecs = ['Utilities','Tutorial', 'Config']

  subspecs.each do |subspec|
    s.subspec subspec do |ss|
      ss.source_files = subspec + '/*'
      ss.resources = subspec + '/{assets,images,fonts,UI,audio}/*'
      ss.frameworks = 'Foundation','SystemConfiguration','GameKit'
    end
  end

  s.dependency 'Fabric'  
  s.dependency 'Crashlytics'  
  s.dependency 'Mixpanel'
  s.dependency 'Amplitude-iOS'
  s.dependency 'Parse'
  s.dependency 'AFNetworking'
  #s.dependency 'Leanplum-iOS-SDK'

end