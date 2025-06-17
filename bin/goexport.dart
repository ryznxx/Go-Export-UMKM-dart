import 'package:goexport/ioselector.dart';
import 'management.dart';
import 'dart:io';
import 'export.dart';
import 'package:goexport/extendbinarytree.dart';

Set<String> mainMenu = {"Export", "Manage", "Exit"};

var welcome = r'''
=======================================================================
    ____           _____                       _       ____ _     ___ 
   / ___| ___     | ____|_  ___ __   ___  _ __| |_    / ___| |   |_ _|
  | |  _ / _ \    |  _| \ \/ / '_ \ / _ \| '__| __|  | |   | |    | | 
  | |_| | (_) |   | |___ >  <| |_) | (_) | |  | |_   | |___| |___ | | 
   \____|\___/    |_____/_/\_\ .__/ \___/|_|   \__|   \____|_____|___|
                             |_|                                        
=======================================================================
''';

void handleAllMenu(BinaryTreeIn distrib) async {
  stdout.write("\x1B[2J\x1B[H");
  print(welcome);

  int selected = ioselector(mainMenu.toList());
  var a = (selected + 1).toString();

  if (a == "1") {
    return await handleExportMenu(distrib);
  }

  if (a == "2") {
    return handleManagement(distrib);
  }

  if (a == "3") {
    exit(1);
  }
}

Future<void> main() async {
  final BinaryTreeIn<String> globalDistribusi = BinaryTreeIn<String>();
  await _restoreTreeData(globalDistribusi);
  return handleAllMenu(globalDistribusi);
}

Future<void> _restoreTreeData(BinaryTreeIn<String> tree) async {
  try {
    final file = File("db/dbtree.json");

    if (!await file.exists()) {
      final dir = Directory("db");
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      tree.addRoot("Export");
      print("🆕 Membuat tree baru karena file tidak ditemukan");
      return;
    }

    await tree.restoreFromFile("db/dbtree.json");
    print("✅ Data tree berhasil dimuat dari file");

    if (tree.root == null) {
      tree.addRoot("Export");
      print("⚠️ Tree kosong, menambahkan root default");
    }
  } catch (e) {
    print("❌ Gagal memuat data: $e");
    tree.addRoot("Export");
    print("🆕 Membuat tree baru karena error memuat file");
  }
}
