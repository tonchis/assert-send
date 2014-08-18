Gem::Specification.new do |s|
  s.name = "assert-send"
  s.version = "0.0.2"
  s.summary = "Easy message expectation for tests in Ruby"
  s.description = s.summary
  s.authors = ["Lucas Tolchinsky"]
  s.email = ["lucas.tolchinsky@gmail.com"]
  s.homepage = "https://github.com/tonchis/assert-send"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency "cutest"
  s.add_development_dependency "mocoso"
end
