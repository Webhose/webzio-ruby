Gem::Specification.new do |s|
  s.name          = 'webzio'
  s.version       = '1.0.0'
  s.licenses      = ['MIT']
  s.summary       = 'webz.io client'
  s.description   = 'webz.io client for Ruby'
  s.authors       = ['Jakub Roman']
  s.files = `git ls-files`.split($/)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.homepage      = 'https://webz.io'
end
