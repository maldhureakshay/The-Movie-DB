# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'NexinoMovies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'ObjectMapper', '2.2.1'
  pod 'AlamofireDomain', '4.1'
  pod 'SDWebImage', '~> 4.0'
  pod 'FMDB/FTS'
  # Pods for NexinoMovies

end

target 'NexinoMoviesTests' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    pod 'ObjectMapper', '2.2.1'
    pod 'AlamofireDomain', '4.1'
    pod 'SDWebImage', '~> 4.0'
    pod 'FMDB/FTS'
    # Pods for NexinoMovies
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = "4.0"
        end
    end
end
