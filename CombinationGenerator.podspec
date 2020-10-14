Pod::Spec.new do |s|
  s.name             = 'CombinationGenerator'
  s.version          = '0.2.2'
  s.summary          = 'CombinationGenerator allows you to generate as many combinations for as you want for a concrete DataModel'
  s.description      = "CombinationGenerator is so useful to explore and test all the possibilities that a concrete DataModule could have. It could be applied for Testing or UITesting purpose, for populate all the possible values or simply to use brute force."

  s.homepage         = 'https://github.com/cosmicfools/CombinationGenerator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Francisco Javier Trujillo Mata' => 'fjtrujy@gmail.com' }
  s.source           = { :git => 'https://github.com/cosmicfools/CombinationGenerator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/fjtrujy'

  s.ios.deployment_target = '9.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.2' }
  s.swift_version = '5.2'

  s.source_files = 'Sources/CombinationGenerator/**/*'
  s.dependency 'Runtime', '~> 2.2.2'
end
