files = Dir['**/*'].select { |f| !f.match /\.gemspec/ }

puts files

Gem::Specification.new do |s|
  s.name = %q{gitlocker}
  s.version = '0.1.0'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Alex R. Young']
  s.date = %q{2009-10-31}
  s.description = %q{Gitlocker is restful git.}
  s.email = %q{alex@alexyoung.org}
  s.files = files 
  s.has_rdoc = false
  s.homepage = %q{http://github.com/alexyoung/gitlocker}
  s.summary = %q{This is a small web app that wraps git in a HTTP interface.}
end


