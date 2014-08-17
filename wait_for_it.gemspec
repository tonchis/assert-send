Gem::Specification.new do |s|
  s.name = "wait_for_it"
  s.version = "0.0.1"
  s.summary = "Easy message expectation for tests in Ruby"
  s.description = s.summary
  s.authors = ["Lucas Tolchinsky"]
  s.email = ["lucas.tolchinsky@gmail.com"]
  s.homepage = "https://github.com/tonchis/wait_for_it"
  s.license = "MIT"
  s.files = `git ls-files`.split("\n")
  s.add_development_dependency "cutest"
end
