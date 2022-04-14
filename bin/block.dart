import 'dart:convert';
import 'package:crypto/crypto.dart';

class Block {
  String hash = "";
  String? prev_hash = null;
  int height;
  int nonce = 0;
  List data = [];

  Block(this.prev_hash, this.height) {
    this.hash = digest();
  }

  String digest() {
    return sha256.convert(utf8.encode(toJsonNoHash())).toString();
  }

  Map toMap() {
    Map map = {
      "hash": hash,
      "prev_hash": prev_hash,
      "height": height,
      "nonce": nonce,
      "data": []
    };

    for (int i = 0; i < data.length; i++) {
      map["data"].add(data[i].toMap());
    }

    return map;
  }

  String toJson() => json.encode(toMap());

  String toJsonNoHash() {
    Map mapWithoutHash = toMap();
    mapWithoutHash.remove("hash");
    return json.encode(mapWithoutHash);
  }

  bool validPow() {
    if (hash.startsWith("000")) return true;
    return false;
  }
}
