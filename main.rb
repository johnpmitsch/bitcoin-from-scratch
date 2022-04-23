# typed: strict

extend T::Sig

sig {returns(String)}
def hello_world
  return "hello"
end

puts hello_world
