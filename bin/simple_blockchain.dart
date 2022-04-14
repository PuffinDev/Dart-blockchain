import 'data.dart';
import 'blockchain.dart';
import 'miner.dart';
import 'mempool.dart';

import 'dart:io';

void main() {
  Blockchain blockchain = Blockchain();

  while (true) {
    print("Data to include in next block: ");
    Data data = Data(stdin.readLineSync());
    blockchain.mempool.add(data);

    blockchain.add(mineNewBlock(blockchain));

    print("\nCURRENT CHAIN: ");
    for (int i = 0; i < blockchain.chain.length; i++) {
      print("${i} | ${blockchain.chain[i].toJson()}");
    }
    print("\n");
  }
}
