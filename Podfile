platform :ios, '9.0'
use_frameworks!

def default_pods
    pod 'FBSDKLoginKit', '~> 4.26'
    pod 'FBSDKCoreKit', '~> 4.26'
    pod 'Alamofire', ‘4.3.0’
    pod 'SDWebImage'

#    pod 'MFCard'
    #εντροπία
end

target 'bykestation' do
    default_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
