
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "theysaidso/version"

Gem::Specification.new do |spec|
  spec.name          = "theysaidso"
  spec.version       = Theysaidso::VERSION
  spec.authors       = ["@Sofia"]
  spec.email         = ["tzi.sof@gmail.com\n\n\n"]

  spec.summary       = %q{CLI tool to give you random quotes.}
  spec.description   = %q{Gets you random quotes from the TheySaidSo API.}
  spec.homepage      = "https://github.com/siwS/theysaidso"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/siwS/theysaidso"
    spec.metadata["changelog_uri"] = "https://github.com/siwS/theysaidso"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = ["theysaidso"]
  spec.require_paths = ["lib"]
  spec.bindir        = "bin"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
