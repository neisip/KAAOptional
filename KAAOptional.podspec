Pod::Spec.new do |s|

  s.name         = "KAAOptional"
  s.version      = "1.0.0"
  s.summary      = "Optionals for Objective-C"
  s.description  = <<-DESC
  KAAOptional provides Optionals with following features:
  1) Generics
  2) Dot notations
  3) Chaining!
  4) Dictionary subscription now returns Optionals!
  5) Optionals don't crash on message which they don't know. (Same way as nil)
  6) Optionals proxy messages to it's content!
  7) Interoperable with swift!
  8) Java 8 syntax
                   DESC
  s.homepage     = "https://github.com/neisip/KAAOptional"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Alexander Kazartsev" => "alex.a.kazartsev@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/neisip/KAAOptional.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "KAAOptional/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
end
