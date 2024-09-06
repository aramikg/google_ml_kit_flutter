require 'yaml'

pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))
library_version = pubspec['version'].gsub('+', '-')

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = library_version
  s.summary          = pubspec['description']
  s.description      = pubspec['description']
  s.homepage         = pubspec['homepage']
  s.license          = { :file => '../LICENSE' }
  s.authors          = 'Multiple Authors'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  # Update the dependency for GoogleMLKit/Translate to work with Firebase 11.0.0
  s.dependency 'GoogleMLKit/Translate', '~> 6.2.0'
  s.dependency 'GoogleDataTransport', '~> 10.1'
  # Ensure google_mlkit_commons is compatible with the required version of MLKit and GoogleDataTransport
  s.dependency 'google_mlkit_commons', '~> 0.7.1'

  s.platform = :ios, '12.0'
  s.ios.deployment_target = '12.0'
  s.static_framework = true
  s.swift_version = '5.0'

  # Flutter.framework does not contain an i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
