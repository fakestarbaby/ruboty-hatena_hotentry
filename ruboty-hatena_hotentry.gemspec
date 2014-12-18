lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/hatena_hotentry/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-hatena_hotentry"
  spec.version       = Ruboty::HatenaHotentry::VERSION
  spec.authors       = ["Fukui ReTu"]
  spec.email         = ["s0232101@gmail.com"]
  spec.summary       = "An ruboty handler to reference hotentry from HatenaBookmark"
  spec.homepage      = "https://github.com/fukuiretu/ruboty-hatena_hotentry"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruboty"
  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake"
end
