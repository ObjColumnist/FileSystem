Pod::Spec.new do |s|
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  
  s.name     = 'FileSystem'
  s.summary  = 'FileSystem is a simple and concise protocol orientated framework for dealing with the file system on iOS, tvOS, watchOS and macOS.'
  s.version  = '0.3'
  s.homepage = 'https://github.com/ObjColumnist/FileSystem'
  s.author   = { "Spencer MacDonald" => "spencer.macdonald@gmail.com" }
  s.license  = { :type => 'BSD (3-clause)', :file => 'LICENSE' }
  s.source   = { :git => 'https://github.com/ObjColumnist/FileSystem.git', :tag => "0.3" }
  s.source_files = 'Source/*.swift'
  s.requires_arc = true
end
