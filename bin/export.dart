import 'package:goexport/extendbinarytree.dart';
import 'package:goexport/iobanner.dart';
import 'package:goexport/ioplate.dart';
import 'package:goexport/ioselector.dart';
import 'package:goexport/queue.dart';
import 'goexport.dart';
import "history.dart";
import "globals.dart";
import "dart:convert";

Set<String> exportMenu = {
  "Input Barang baru",
  "Hapus Barang antrian terbaru",
  "bersihkan seluruh antrian",
  "Cek Antrian",
  "Kirim Antrian",
  "Cek History Antrian",
  "Kembali ke main menu"
};

QueueManual antrian = QueueManual();

Future<void> handleExportMenu(BinaryTreeIn treed) async {
  ioBanner("Export Menu");
  int selected = ioselector(exportMenu.toList());
  var ans = (selected + 1);

  if (ans == 1) {
    inputBarangExport(treed);
    return assign.nextAction(() => handleExportMenu(treed));
  }

  if (ans == 2) {
    try {
      var a = antrian.dequeue();
      logthis.success("Berhasil hapus $a");
    } catch (e) {
      logthis.error("Error : $e");
    }
    return assign.nextAction(() => handleExportMenu(treed));
  }

  if (ans == 3) {
    if (antrian.isEmpty) {
      logthis.info("antrian kosong, tidak perlu pembersihan");
      return assign.nextAction(() => handleExportMenu(treed));
    }

    while (!antrian.isEmpty) {
      antrian.dequeue();
    }

    logthis.success("antrian telah dikosongkan/dibersihkan");
    return assign.nextAction(() => handleExportMenu(treed));
  }

  if (ans == 4) {
    print("");
    cekAntrianBarangExport();
    return assign.nextAction(() => handleExportMenu(treed));
  }

  if (ans == 5) {
    if (antrian.length > 0) {
      var domisiliAsk = ioQuestion(
          "Admin mewajibkan menyertakan domisili export\nuntuk seluruh barang/ jika sudah ditambahkan per barang, boleh kosongkan opsi ini : ");
      Map<String, dynamic> newData = {
        "domisiliExport": domisiliAsk,
        "barang": antrian.fullContentList()
      };
      List extractedAntrian = antrian.fullContentList();

      if (!treed.hasChild(domisiliAsk)) {
        if (treed.root != null) {
          treed.addChild("Export", domisiliAsk);
        }
      }

      for (var i = 0; i < extractedAntrian.length; i++) {
        Map<String, dynamic> newDataA = {
          "namaBarang": extractedAntrian[i]["namaBarang"],
          "dataSpesifik": extractedAntrian[i],
        };

        var convertedValidData = jsonEncode(newDataA);

        treed.addChild(domisiliAsk, convertedValidData);
      }

      globalHistory.addHistory(newData);
      antrian.transferQueue(globalAntrian);
      logthis.success(
          "Semua Barang Yang Dicacatan Antrian Telah berhasil dikirim ke pusat");
      await saved(treed);
      return assign.nextAction(() => handleExportMenu(treed));
    }
    logthis.info("Antrian kosong");
    return assign.nextAction(() => handleExportMenu(treed));
  }

  if (ans == 6) {
    return handleHistory(treed);
  }

  if (ans == 7) {
    return handleAllMenu(treed);
  }

  return assign.invalidChoose(handleExportMenu);
}

void cekAntrianBarangExport() {
  antrian.printInfo();
}

void inputBarangExport(BinaryTreeIn fn) async {
  String namaBarang = ioQuestion("Nama Barang yang mau dimasukkan : ");
  if (namaBarang.isEmpty) {
    return assign.retry(
        () => inputBarangExport(fn), "Nama barang tidak boleh kosong");
  }

  String hargaInput = ioQuestion("Harga Barang yang mau dimasukkan : ");
  int? hargaBarang = int.tryParse(hargaInput);
  if (hargaBarang == null) {
    return assign.retry(() => inputBarangExport(fn),
        "Harga barang harus berupa angka dan tidak boleh kosong");
  }

  String exportBarang = ioQuestion("Export Barang Ke Negara : ");
  if (exportBarang.isEmpty) {
    return assign.retry(
        () => inputBarangExport(fn), "Export Negara Barang tidak boleh kosong");
  }
  String kategoriBarang = ioQuestion(
      "Kategori Barang yang mau dimasukkan (pisahkan menggunakan koma) : ");
  if (kategoriBarang.isEmpty) {
    return assign.retry(
        () => inputBarangExport(fn), "Kategori barang tidak boleh kosong");
  }

  antrian.enqueue({
    "namaBarang": namaBarang,
    "hargaBarang": hargaBarang,
    "exportBarang": exportBarang.toLowerCase(),
    "kategoriBarang": kategoriBarang
  });

  logthis.success(
      "Barang \"$namaBarang\" telah ditambahkan ke antrian dengan export domisili $exportBarang. Segera cek antrian barang.");
}

Future<void> saved(BinaryTreeIn distrib) async {
  final filePath = "db/dbtree.json";
  await distrib.saveToFile(filePath);
  print("saved");
}
