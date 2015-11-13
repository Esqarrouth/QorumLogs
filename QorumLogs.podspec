Pod::Spec.new do |s|
s.name             = "QorumLogs"
s.version          = "0.2"
s.summary          = "Swift Logging Utility for Xcode & Google Docs"
s.description      = "Swift Logging Utility for Xcode & Google Documents"
s.homepage         = "https://github.com/goktugyil/QorumLogs"
s.license          = 'MIT'
s.author           = { "goktugyil" => "gok-2@hotmail.com" }
s.source           = { :git => "https://github.com/goktugyil/QorumLogs.git", :tag => s.version.to_s }
s.platform     = :ios, '8.0'
s.requires_arc = true
s.source_files = 'QorumLogs.swift'

end