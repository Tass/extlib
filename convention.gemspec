# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{convention}
  s.version = "0.0.1"

  s.authors = ["Dan Kubb", "Simon Hafner"]
  s.description = %q{Support library for basic conventions}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{http://github.com/Tass/extlib}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Provies inflection and snake/camel_case either via extlib or AS or by itself.}
end

