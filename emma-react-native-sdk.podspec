require 'json'
pkg = JSON.parse(File.read("package.json"))

Pod::Spec.new do |s|
  s.author           = pkg["author"]
  s.homepage         = pkg["homepage"]
  s.license          = pkg["license"]
  s.name             = pkg["name"]
  s.platform         = :ios, "9.0"
  s.requires_arc     = true

  # REMOTE
  s.source           =  { :git => pkg["repository"]["url"], :tag => pkg["version"] }
  s.source_files     = 'ios/*.{h,m,swift}'

  # LOCAL
  #s.source           =  { :git => '../../' }
  #s.source_files     = 'ios/*.{h,m,swift}'

  s.static_framework = true
  s.summary          = pkg["description"]
  s.version          = pkg["version"]
  s.dependency 'React'
  s.dependency 'eMMa', '~> 4.11.3'
end
