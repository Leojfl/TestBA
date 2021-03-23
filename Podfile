platform :ios, '14.0'

target 'TestBA' do
  use_frameworks!

  # Pods for TestBA
  pod 'MaterialComponents/TextFields'
  pod 'MaterialComponents/Buttons'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RealmSwift'
  
  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
   end
  end

end
