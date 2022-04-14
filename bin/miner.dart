import 'block.dart';

Block mineNewBlock(blockchain) {
  Block block = blockchain.new_block();

  while (!block.validPow()) {
    block.nonce += 1;
    block.hash = block.digest();
  }

  print("Mined block #${block.height}");
  return block;
}
