source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'JarCurrency' do
    
    # Alamofire
    pod 'Alamofire', '~> 4.7'
    pod 'AlamofireImage', '~> 3.3'
    
    # Rx
    pod 'RxAlamofire'
    pod 'RxSwift'
    pod 'RxCocoa'

    # DI
    pod 'Swinject'
        
    # SwiftSoup
    pod 'SwiftSoup'
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

