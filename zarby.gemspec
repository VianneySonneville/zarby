# frozen_string_literal: true

require_relative "lib/zarby/version"

Gem::Specification.new do |spec|
  spec.name = "zarby"
  spec.version = Zarby::VERSION
  spec.authors = ["vianney.sonneville"]
  spec.email = ["vianneysonneville4@gmail.com"]

  spec.summary = "String encoding and decoding with Ruby."
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://guides.rubygems.org"
  spec.required_ruby_version = ">= 2.6.0"
  spec.licenses = ['MIT']

  spec.metadata = { 
    "source_code_uri" => "https://github.com/VianneySonneville/zarby",  
    "changelog_uri" => "https://github.com/VianneySonneville/zarby/blob/main/CHANGELOG.md"
  }
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "https://github.com/VianneySonneville/zarby/blob/main/CHANGELOG.md"
  # spec.metadata["github_repo"] = "git@github.com:VianneySonneville/zarby.git"
  # spec.metadata["source_code_link"] = "git@github.com:VianneySonneville/zarby.git"
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
<<<<<<< HEAD
  # spec.add_dependency "example-gem", "~> 1.0"

=======
>>>>>>> v0.2.0
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
