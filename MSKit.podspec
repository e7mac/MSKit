Pod::Spec.new do |s|
  s.name             = "MSKit"
  s.version          = "1.0.0"
  s.summary          = "A set of all the utility classes and extensions used in my iOS projects."
  s.license          = 'MIT'
  s.homepage           = 'http://www.e7mac.com'
  s.author           = { "e7mac" => "mayank.ot@gmail.com" }
  s.source           = { :git => "https://github.com/e7mac/MSKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/e7mac'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.subspec 'Config' do |ss|
    ss.source_files = 'Config/*'
    ss.resources = 'Config/{assets,images,fonts,UI,audio}/*'
  end

  s.subspec 'Tutorial' do |ss|
    ss.source_files = 'Tutorial/*'
    ss.resources = 'Tutorial/{assets,images,fonts,UI,audio}/*'
    ss.dependency 'MSKit/Config'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'Core/*'
    ss.resources = 'Core/{assets,images,fonts,UI,audio}/*'
  end
end