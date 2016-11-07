Pod::Spec.new do |s|
  s.name         = "ZOEBannerView"
  s.version      = "1.0.1"
  s.summary      = "AdView or LoopView"
  s.homepage     = "https://github.com/KuratasZ"
  s.license      = "MIT"
  s.authors      = { 'ZOE' => 'z.o.e@outlook.com'}
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/KuratasZ/ZOEBannerView.git", :tag => s.version }
  s.source_files = 'ZOEBannerView/ZOEBannerView/ZOEBannerView/**/*.{h,m}'
  s.requires_arc = true
end
