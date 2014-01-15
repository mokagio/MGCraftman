Pod::Spec.new do |s|
  version = "0.1.0"
  s.name         = "MGCraftman"
  s.version      = version
  s.summary      = "A framework to speedup development when you can't (or don't want to) use Interface Builder."
  s.homepage     = "https://github.com/mokagio/MGCraftman"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Giovanni Lodi" => "mokagio42@gmail.com" }

  s.source       = { :git => "https://github.com/mokagio/MGCraftman.git", :tag => version }
  s.source_files = 'MGCraftman/**/*.{h,m}', 'MGCraftman/Categories/*.{h,m}', 'MGCraftman/Classes/*.{h,m}', 'MGCraftman/Protocols/*.{h,m}'

  s.platform     = :ios

  s.dependency   'CPAnimationSequence', '0.0.4'
end
