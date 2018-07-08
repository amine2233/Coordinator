Pod::Spec.new do |s|
		s.name 				= "Coordinator"
		s.version 			= "1.2.0"
		s.summary         	= "Short description of 'Coordinator' framework"
	    s.homepage        	= "https://github.com/amine2233/Coordinator"
	    s.license           = "MIT"
	    s.author            = { 'Amine Bensalah' => 'amine.bensalah@outlook.com' }
	    s.ios.deployment_target = '10.0'
	    s.osx.deployment_target = '10.12'
	    s.tvos.deployment_target = '10.0'
	    s.watchos.deployment_target = '3.0'
	    s.requires_arc = true
	    s.source            = { :git => "https://github.com/amine2233/Coordinator.git", :tag => s.version.to_s }
	    s.source_files      = "Sources/**/*.swift"
	    s.pod_target_xcconfig = {
    		'SWIFT_VERSION' => '4.1'
  		}
  		s.module_name = s.name
  		s.swift_version = '4.1'

  		s.ios.exclude_files = "Sources/AppKit", "Sources/WatchKit"
  		s.tvos.exclude_files = "Sources/AppKit", "Sources/WatchKit"
  		s.osx.exclude_files = "Sources/UIKit", "Sources/WatchKit"
  		s.watchos.exclude_files = "Sources/AppKit", "Sources/UIKit"
	end
