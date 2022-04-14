import 'block.dart';
import 'mempool.dart';

class Blockchain {
  List chain = [];
  Mempool mempool = Mempool();

  Blockchain() {
    chain.add(genesis_block());
  }

  List blockInv() {
    List blockInventory = [];
    for (int i = 0; i > chain.length; i++) {
      Block block = chain[i];
      blockInventory.add(block.hash);
    }

    return blockInventory;
  }

  void add(Block block) {
    if (isValidBlock(block)) {
      chain.add(block);
      mempool.clearIncludedData(this);
    }
  }

  bool isValidBlock(block) {
    if (!block.validPow()) {
      print("Block #${block.height} --> Invalid PoW");
      return false;
    } else if (block.prev_hash != last_block().hash) {
      print("Block #${block.height} --> Invalid previous hash");
      return false;
    } else if (block.height != last_block().height + 1) {
      print("Block #${block.height} --> Invalid height");
      return false;
    } else if (block.digest() != block.hash) {
      print("Block #${block.height} --> Invalid hash");
      return false;
    } else if (blockInv().contains(block.hash)) {
      print("Block #${block.height} --> Invalid: Duplicate block");
      return false;
    }

    return true;
  }

  Block last_block() => chain[chain.length - 1];

  Block genesis_block() {
    Block block = Block(null, 0);

    return block;
  }

  Block new_block() {
    Block block = Block(last_block().hash, last_block().height + 1);

    for (int i = 0; i < mempool.pool.length; i++)
      block.data.add(mempool.pool[i]);

    return block;
  }

  void create_new_block() {
    Block block = new_block();
    chain.add(block);
  }
}
