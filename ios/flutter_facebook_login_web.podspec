#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_facebook_login_web'
  s.version          = '0.2.0'
  s.summary          = 'No-op implementation of flutter_login_facebook_web plugin to avoid build issues on iOS'
  s.description      = <<-DESC
temp fake flutter_login_facebook_web plugin
                       DESC
  s.homepage         = 'https://github.com/kfiross/flutter_facebook_login_web'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Kfir Matityahu' => 'kfir25812@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

