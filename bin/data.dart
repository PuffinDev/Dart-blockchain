import 'package:crypto/crypto.dart';
import 'dart:convert';

class Data {
  int time = DateTime.now().millisecondsSinceEpoch;
  String? text;
  String? hash;

  Data(text) {
    this.text = text;
    this.hash = sha256.convert(utf8.encode(toJsonNoHash())).toString();
  }

  Map toMap() => {"time": time, "text": text, "hash": hash};

  String toJson() => json.encode(toMap());
  String toJsonNoHash() => json.encode(toMap().remove("hash"));
}
