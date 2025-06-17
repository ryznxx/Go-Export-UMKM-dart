import 'package:goexport/extendbinarytree.dart';
import 'package:goexport/helper.dart';
import 'package:goexport/iobanner.dart';
import 'package:goexport/ioselector.dart';
import 'globals.dart';
import 'dart:io';
import 'management.dart';
import 'relocation.dart';

void recheckBarang(BinaryTreeIn distrib) {
  distrib.preOrder((data) {
    final nama = distrib.extractNamaBarang(data);
    final domisili = distrib.extractDomisiliBarang(data);

    if (nama != null) stdout.write("\n$nama");
    if (domisili != null && domisili.trim().isNotEmpty) {
      stdout.write(" export ke $domisili");
    }
  });
  print("");
}

Future<void> gantiLokasiExport(BinaryTreeIn distrib) async {
  final List<dynamic> rawData = [];
  final List<String> hasilExport = [];
  final List<Map> mappedData = [];

  distrib.preOrder((data) => rawData.add(data));

  for (final item in rawData) {
    final mapData = parseToMap(item);
    if (mapData == null) continue;
    mappedData.add(mapData);
    final nama = mapData['namaBarang'];
    final exportTujuan = mapData['dataSpesifik']?['exportBarang'];

    if (nama != null && exportTujuan != null) {
      hasilExport.add("$nama tujuan ekspor $exportTujuan");
    }
  }

  int nomorPilihan = iopicker(hasilExport);
  await relocation(distrib, mappedData[nomorPilihan]);
}

Future<void> exportKeTujuan(BinaryTreeIn distrib) async {
  print("Barang Segera Di Export Ke Tujuan Masing masing");
  print("Barang sudah dikirimkan!");
  try {
    final file = File("db/dbtree.json");
    if (file.existsSync()) {
      file.deleteSync();
    } else {
      print("Management book kosong, belom terdata di database");
    }
  } catch (e) {
    print("ERROR BANGSAT: $e");
  }
}

Future<void> kembaliKeMenu(BinaryTreeIn distrib) async {
  return await handleManagement(distrib);
}

final Map<int, Map<String, dynamic>> exportMenu = {
  1: {
    "judulFungsi": "Re-check Barang",
    "fungsi": recheckBarang,
  },
  2: {
    "judulFungsi": "Ganti Lokasi Export Barang",
    "fungsi": gantiLokasiExport,
  },
  3: {
    "judulFungsi": "Export ke tujuan",
    "fungsi": exportKeTujuan,
  },
  4: {
    "judulFungsi": "Kembali ke manage",
    "fungsi": kembaliKeMenu,
  },
};

Future<void> handleExportManagement(BinaryTreeIn distrib) async {
  ioBanner("Export Management");

  List<String> opsi =
      exportMenu.values.map((e) => e["judulFungsi"] as String).toList();
  int selected = ioselector(opsi);
  int pilihan = selected + 1;

  if (exportMenu.containsKey(pilihan)) {
    Function f = exportMenu[pilihan]!["fungsi"];
    f(distrib);
  }

  if (pilihan != 4) {
    return await assign.nextAction(() => handleExportManagement(distrib));
  }
}
