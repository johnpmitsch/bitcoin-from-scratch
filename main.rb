# typed: strict

require_relative "blockchain"

chain = initialize_blockchain()
chain.add_block("Hey! Look at that!")
chain.add_block("We have deterministic hashes")
chain.add_block("based on prev block hash and the block's data!")
chain.blocks.each do |b|
  puts "------------------\nBlock #{b._hash}\nPrevious Hash: #{b.prev_hash}\nData: #{b.data}\n"
end