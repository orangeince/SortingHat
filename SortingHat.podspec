Pod::Spec.new do |s|
  s.name             = 'SortingHat'
  s.version          = '0.2.3'
  s.summary          = 'A lightweight and pure swift library for router.'

  s.description      = <<-DESC
    SortingHat is a powerful and pure swift library for router.
    It support not only URL routing, but also internal invoke between modules.
                       DESC

  s.homepage         = 'https://github.com/orangeince/SortingHat'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Shao' => 'orangeince@outlook.com' }
  s.source           = { :git => 'https://github.com/orangeince/SortingHat.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/xiaoyipie'

  s.swift_version = '4.2'
  s.ios.deployment_target = '10.0'

  s.source_files = ['Sources/**/*.swift', "Sources/SortingHat.h"]
  
end
