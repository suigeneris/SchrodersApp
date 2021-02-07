# Uncomment the next line to define a global platform for your project

target 'SchrodersApp' do
  platform :ios, '10.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Kingfisher', '~> 6.0'
  pod 'SnapKit', '~> 5.0.0'

  # Pods for SchrodersApp

  target 'SchrodersAppTests' do
    inherit! :search_paths
    platform :ios, '12.0'

    pod 'SnapshotTesting', '~> 1.8.1'
    pod 'Quick'
    pod 'Nimble'
  end

  target 'SchrodersAppUITests' do
    # Pods for testing
  end

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
end
