# typed: strict

require 'sorbet-runtime'
require 'digest'
extend T::Sig

# Take data from the block

# create a counter (nonce) that starts at 0

# create a hash of the data plus the counter

# check the hash to see if it meets a set of requirements - first few bytes are zero

difficulty = 12

class ProofOfWork < T::Struct
  extend T::Sig

  const :block, Block
  const :target, Fixnum
end

