
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "riverrun/version"

Gem::Specification.new do |spec|
  spec.name          = "riverrun"
  spec.version       = RiverRun::VERSION
  spec.authors       = ["Andrew Johnson"]
  spec.email         = ["ajohnson.uva@gmail.com"]

  spec.summary       = %q{Practice writing a gem for a basic CLI app}
  spec.description   = %q{A CLI for RiverRun Film Festival, particularly their upcoming events}
  spec.homepage      = "https://github.com/aaj3f/riverrun"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/aaj3f/riverrun"
    spec.metadata["changelog_uri"] = "https://github.com/aaj3f/riverrun/commits/master"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "colorize"

  # spec.add_runtime_dependency "open-uri"
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "colorize"

  # spec.add_runtime_dependency "io/console"
end
