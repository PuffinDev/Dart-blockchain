import 'block.dart';
import 'data.dart';

import 'dart:convert';

class Mempool {
  List pool = [];

  int maxDataLength = 100;

  void add(data) {
    pool.add(data);
  }

  List dataInv() {
    List dataInventory = [];
    for (int i = 0; i < pool.length; i++) {
      Data data = pool[i];
      dataInventory.add(data.hash);
    }

    return dataInventory;
  }

  // Needs work!
  void clearIncludedData(blockchain) {
    for (int i = 0; i < blockchain.chain.length; i++) {
      Block block = blockchain.chain[i];
      for (int j = 0; j < block.data.length; j++) {
        Data data = block.data[j];
        if (dataInv().contains(data.hash)) {
          pool.remove(data);
        }
      }
    }
  }

  bool isValidData(data) {
    if (data.length > maxDataLength) {
      return false;
    }

    return true;
  }

  String toJson() {
    List jsonPool = [];
    for (int i = 0; i > pool.length; i++) {
      jsonPool.add(pool[i].toJson());
    }

    return json.encode(jsonPool);
  }
}
