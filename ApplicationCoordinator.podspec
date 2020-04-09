Pod::Spec.new do |s|

s.name         = "ApplicationCoordinator"
s.version      = "0.1.0"
s.summary      = "A simple application coordinator that assists the subpages to navigate to other pages using URLRequests"
s.swift_version = '4.2'
s.description  = <<-DESC
A description about your framework
DESC

s.homepage     = "https://github.com/davidthorn/swift-application-coordinator.git"

s.license      = { :type => "MIT" }

s.author       = { "David Thorn" => "david.thorn221278@googlemail.com" }

s.ios.deployment_target = "9.0"

s.source       = { :git => "https://github.com/davidthorn/swift-application-coordinator.git", :tag => "#{s.version}" }

s.source_files  = "ApplicationCoordinator/**/*.{swift}"

end
