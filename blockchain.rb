# typed: strict

require 'sorbet-runtime'
require 'digest'
extend T::Sig

# Create a new class that subclasses sorbet's `T::Struct`
class Block < T::Struct
  extend T::Sig
  # Declare fields on the struct with the `prop` and `const` DSL
  # `prop` is able to be changed and not required for initialization
  # `const` cannot be changed after initialization and required for initialization
  prop :_hash, T.nilable(String) # using _hash because "a method with that name already exists" for hash
  const :data, String
  const :prev_hash, String

  # Deriving hash from previous hash and data inside block
  sig {returns(String)}
  def derive_hash
    derived_hash = Digest::SHA256.hexdigest self.data + self.prev_hash
    self._hash = derived_hash
  end
end

class Blockchain < T::Struct
  extend T::Sig

  prop :blocks, T::Array[Block], default: []

  sig {params(data: String).returns(Block)}
  def add_block(data)
    prev_block = self.blocks[self.blocks.length - 1]
    prev_hash = T.must(prev_block)._hash || ""
    new_block = create_block(data, prev_hash)
    self.blocks << new_block
    return new_block
  end
end

sig {params(data: String, prev_hash: String).returns(Block)}
def create_block(data, prev_hash)
  block = Block.new(data: data, prev_hash: prev_hash)
  block.derive_hash
  return block
end

sig {returns(Block)}
def genesis_block()
  return create_block("NY Times 12/Apr/2022 Inflation Hits Fastest Pace Since 1981, at 8.5% Through March", "")
end

sig {returns(Blockchain)}
def initialize_blockchain()
  chain = Blockchain.new
  # Initialize with the genesis block so we always have a previous has for subsequent blocks
  chain.blocks << genesis_block
  return chain
end
