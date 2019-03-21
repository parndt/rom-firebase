# frozen_string_literal: true

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'rom-firebase'
  s.version           = '0.1.0'
  s.summary           = 'Firebase support for ROM'
  s.description       = s.summary
  s.email             = 'gems@p.arndt.io'
  s.homepage          = 'https://github.com/parndt/rom-firebase'
  s.authors           = ['Philip Arndt']
  s.license           = 'MIT'
  s.bindir            = 'exe'
  s.require_paths     = %w[lib]

  s.files             = `git ls-files -- lib/*`.split("\n")

  s.add_runtime_dependency 'firebase', '~> 0.2.8'
  s.add_runtime_dependency 'rom-http', '~> 0.7.0'

  s.required_ruby_version = '>= 2.6.1'

  s.cert_chain = [File.expand_path('certs/parndt.pem', __dir__)]

  if $PROGRAM_NAME.end_with?('gem') && ARGV.include?('build') && ARGV.include?(__FILE__)
    s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem')
  end
end
