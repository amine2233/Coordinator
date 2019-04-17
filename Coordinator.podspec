Pod::Spec.new do |s|
		s.name 				= "Coordinator"
		s.version 			= "2.0.0"
		s.summary         	= "Short description of 'Coordinator' framework"
	    s.homepage        	= "https://github.com/amine2233/Coordinator"
	    s.license           = "MIT"
	    s.author            = { 'Amine Bensalah' => 'amine.bensalah@outlook.com' }
	    s.ios.deployment_target = '10.0'
	    s.osx.deployment_target = '10.12'
	    s.tvos.deployment_target = '10.0'
	    s.watchos.deployment_target = '4.0'
	    s.requires_arc = true
	    s.source            = { :git => "https://github.com/amine2233/Coordinator.git", :tag => s.version.to_s }
	    s.source_files      = "Sources/Coordinator/**/*.swift"
  		s.module_name = s.name
  		s.swift_version = '5.0'

		# UIKit Extensions
  		s.subspec 'UIKit' do |sp|
    		sp.source_files  = 'Sources/Coordinator/UIKit/*.swift', 'Sources/Coordinator/RootViewCoordinator/*.swift'
  		end

		# AppKit Extensions
		s.subspec 'AppKit' do |sp|
			sp.source_files  = 'Sources/Coordinator/AppKit/*.swift', 'Sources/Coordinator/RootViewCoordinator/*.swift'
		end

		# WatchKit Extensions
		s.subspec 'WatchKit' do |sp|
			sp.source_files  = 'Sources/Coordinator/WatchKit/*.swift', 'Sources/Coordinator/RootViewCoordinator/*.swift'
		end
	end
