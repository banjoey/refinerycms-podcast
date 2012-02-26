Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-podcasts'
  s.version           = '0.9'
  s.description       = 'Ruby on Rails Podcasts engine for Refinery CMS'
  s.date              = '2012-02-09'
  s.summary           = 'Podcasts engine for Refinery CMS'
  s.authors           = ["David Jones"]
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*']
  s.authors           = ['djones', 'Trey Bean', 'Joey Barkley']

  #dependencies
  s.add_dependency('acts-as-taggable-on', '~>2.1.0')
  s.add_dependency('mp3info', '~>0.6.16')
end
