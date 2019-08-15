platform :ios, '9.0'
swift_version = '4.2'

target 'GithubStatusViewer' do
  use_frameworks!

  pod 'APIKit', '~> 3.1'
  pod 'RxSwift', '~> 4'
  pod 'RxCocoa', '~> 4'

  target 'GithubStatusViewerTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 4'
    pod 'RxTest', '~> 4'
  end

  target 'GithubStatusViewerUITests' do
    inherit! :search_paths
  end

end
