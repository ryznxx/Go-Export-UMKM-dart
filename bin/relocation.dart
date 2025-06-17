import 'package:goexport/extendbinarytree.dart';
import 'dart:convert';

import 'package:goexport/ioplate.dart';

Future<void> relocation(BinaryTreeIn tree, Map base) async {
  final diganti = ioQuestion("export dirubah ke?");
  final Map<String, dynamic> originalx = {
    ...base,
    "dataSpesifik": {...base["dataSpesifik"], "exportBarang": diganti}
  };
  tree.findSimilarChildAndReplace(
      (data) => data.contains(jsonEncode(base)), originalx.toString());
  await tree.saveToFile("db/dbtree.json");

  print(tree.toJson());
  print("\n$originalx");
}
