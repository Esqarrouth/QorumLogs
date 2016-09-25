Pod::Spec.new do |s|
s.name            			= "QorumLogs"
s.version          			= "0.9"
s.summary          			= "Swift Logging Utility for Xcode & Google Docs"
s.description      			= "Swift Logging Utility for Xcode & Google Documents"
s.homepage         			= "https://github.com/goktugyil/QorumLogs"
s.license          			= 'MIT'
s.author          			= { "goktugyil" => "gok-2@hotmail.com" }
s.source           			= { :git => "https://github.com/goktugyil/QorumLogs.git", :tag => s.version.to_s }
s.ios.deployment_target 		= "8.0"
s.tvos.deployment_target 		= "9.0"
s.osx.deployment_target 		= "10.9"
s.requires_arc 				= true
s.source_files 				= 'QorumLogs.swift'

end
