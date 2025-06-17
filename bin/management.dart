import 'package:goexport/extendbinarytree.dart';
import 'package:goexport/iobanner.dart';
import 'package:goexport/ioselector.dart';
import "globals.dart";
import 'goexport.dart';
import 'e_management.dart';

Future<void> saved(BinaryTreeIn distrib) async {
  final filePath = "db/dbtree.json";
  await distrib.saveToFile(filePath);
  print("saved");
}

Future<void> manageBarang(BinaryTreeIn distrib) {
  return handleExportManagement(distrib);
}

void lihatTreeView(BinaryTreeIn distrib) {
  print("🖿");
  distrib.printTree();
}

void simpanTreeKeDatabase(BinaryTreeIn distrib) async {
  distrib.printTree();
  await saved(distrib);
  logthis.info("Data berhasil disimpan");
}

void kembaliKeMenu(BinaryTreeIn distrib) {
  return handleAllMenu(distrib);
}

final Map<int, Map<String, dynamic>> managementMenu = {
  1: {
    "judulFungsi": "Manage Barang",
    "fungsi": manageBarang,
  },
  2: {
    "judulFungsi": "Lihat Tree View",
    "fungsi": lihatTreeView,
  },
  // 3: {
  //   "judulFungsi": "Simpan Tree Ke Database",
  //   "fungsi": simpanTreeKeDatabase,
  // },
  3: {
    "judulFungsi": "Kembali ke main menu",
    "fungsi": kembaliKeMenu,
  },
};

Future<void> handleManagement(BinaryTreeIn distrib) async {
  ioBanner("Management");

  List<String> opsi =
      managementMenu.values.map((e) => e["judulFungsi"] as String).toList();
  int selected = ioselector(opsi);
  int pilihan = selected + 1;

  if (managementMenu.containsKey(pilihan)) {
    Function f = managementMenu[pilihan]!["fungsi"];
    f(distrib);
  }

  if (pilihan != 3) {
    return await assign.nextAction(() => handleManagement(distrib));
  }
}
