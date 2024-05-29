# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name = 'hanikamu-active_async'
  s.version = '0.1.0'
  s.authors = ['Nicolai Seerup', 'Alejandro Jimenez']
  s.summary = 'Run your Service as Async with ActiveJobs'
  s.required_ruby_version = '>= 3'

  s.homepage      = 'https://github.com/Hanikamu/hanikamu-service'
  s.license       = 'MIT'

  s.files = Dir['{config,lib}/**/*', 'Rakefile']
  s.require_paths = ['lib']

  s.add_dependency  'activejob', '< 8'
  s.add_dependency  'hanikamu-service', '~> 0.1'

  s.metadata['rubygems_mfa_required'] = 'true'
end
