Pod::Spec.new do |s|
	s.name = "IQCircularProgressView"
	s.version = "1.0.0"
	s.summary = "Circular progress view with progress and indeterminant states."
	s.homepage = "https://github.com/hackiftekhar/IQCircularProgressView"
	s.screenshots = "https://raw.githubusercontent.com/hackiftekhar/IQCircularProgressView/master/Screenshot/Screenshot.jpg"
	s.license = 'MIT'
	s.author = { "Iftekhar Qurashi" => "hack.iftekhar@gmail.com" }
	s.platform = :ios, '7.0'
	s.source = { :git => "https://github.com/hackiftekhar/IQCircularProgressView.git", :tag => "v1.0.0" }
	s.source_files = 'Classes', 'IQCircularProgressView/*.{h,m}'
	s.requires_arc = true
end
