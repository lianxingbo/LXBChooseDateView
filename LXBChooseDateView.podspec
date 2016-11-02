Pod::Spec.new do |s|
  s.name         = "LXBChooseDateView"
  s.version      = "1.0.0"
  s.summary      = " iOS日历、日期选择"
  s.homepage     = "https://github.com/lianxingbo/LXBChooseDateView"
  s.license      = "MIT"
  s.author       = { "Daboge" => "Dabo_iOS@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/lianxingbo/LXBChooseDateView.git", :tag => "1.0.0"}
  s.source_files = "calender/LXBChooseDateView/**/*.{h,m}"
  s.framework    = "UIKit"

end
