# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'wildmat'

Gem::Specification.new do |s|
  s.name        = "wildmat"
  s.version     = Wildmat::VERSION
  s.authors     = ["Gene Hsu"]
  s.email       = ["gene@hsufarm.com"]
  s.homepage    = "https://github.com/genehsu/wildmat"
  s.summary     = %q{A wildmat expression library}
  s.description = %q{A wildmat expression library}

  s.rubyforge_project = "wildmat"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "yard"
  s.add_development_dependency "spec"
end
