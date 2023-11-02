Pod::Spec.new do |spec|

  spec.name                         = 'Nson'
  spec.version                      = '1.0.0'
  spec.summary                      = 'Nson'
  spec.homepage                     = 'https://github.com/devhplusn/Nson'
  spec.license                      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author                       = { 'Hanwoong Na' => 'devhplusn@gmail.com' }
  spec.source                       = { :git => 'https://github.com/devhplusn/Nson.git', :tag => spec.version.to_s }
  spec.ios.deployment_target        = '11.0'
  spec.osx.deployment_target        = '10.13'
  spec.watchos.deployment_target    = '4.0'
  spec.tvos.deployment_target       = '11.0'
  spec.source_files                 = 'Sources/Nson/**/*'
  spec.swift_versions               = ['5']

end
