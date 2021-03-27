Pod::Spec.new do |s|
  s.name         = "FRemocon"
  s.version      = "0.1.0"
  s.summary      = "FRemocon can get the RemoteConfig value type-safely by using Key Path Member Lookup"
  s.homepage     = "https://github.com/funzin/FRemocon"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "funzin" => "nakazawa.fumito@gmail.com" }
  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.12"
  s.tvos.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/funzin/FRemocon.git", :tag => "#{s.version}" }
  s.source_files = "Sources/**/*.{swift}"

  s.dependency 'FirebaseRemoteConfig', '~> 7.0.0'
  s.swift_version = '5.3'
end
