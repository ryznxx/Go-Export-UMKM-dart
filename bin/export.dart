import 'package:goexport/assignment.dart';
import 'package:goexport/iobanner.dart';
import 'package:goexport/ioplate.dart';
import 'package:goexport/ioselector.dart';
import 'package:goexport/log.dart';
import 'package:goexport/queue.dart';
import 'goexport.dart';
import "history.dart";

List<String> exportMenu = [
  "Input Barang baru",
  "Hapus Barang antrian terbaru",
  "Cek Antrian",
  "Kirim Antrian",
  "Cek History Antrian",
  "Kembali ke main menu"
];

Assignment assign = Assignment();
QueueManual antrian = QueueManual();
Logging log = Logging();

void handleExportMenu() {
  ioBanner("Export Menu");

  int selected = ioselector(exportMenu);
  var ans = (selected + 1);

  // input lah
  if (ans == 1) {
    print("");
    inputBarangExport();
    return assign.nextAction(handleExportMenu);
  }

  if (ans == 2) {
    try {
      var a = antrian.dequeue();
      print("Berhasil hapus $a");
    } catch (e) {
      log.error("Error : $e");
    }
    return assign.nextAction(handleExportMenu);
  }

  if (ans == 3) {
    print("");
    cekAntrianBarangExport();
    return assign.nextAction(handleExportMenu);
  }

  if (ans == 4) {
    if (antrian.length > 0) {
      var domisiliAsk = ioQuestion(
          "Admin mewajibkan menyertakan domisili export\nuntuk seluruh barang/ jika sudah ditambahkan per barang, boleh kosongkan opsi ini : ");
      Map<String, dynamic> newData = {
        "domisiliExport": domisiliAsk,
        "barang": antrian.fullContentList()
      };
      globalHistory.addHistory(newData);
      antrian.transferQueue(globalAntrian);
      log.success(
          "Semua Barang Yang Dicacatan Antrian Telah berhasil dikirim ke pusat");
      return assign.nextAction(handleExportMenu);
    } else {
      log.info("Antrian kosong");
    }
  }

  if (ans == 5) {
    handleHistory();
  }

  if (ans == 6) {
    handleAllMenu();
  }

  return assign.invalidChoose(handleExportMenu);
}

void cekAntrianBarangExport() {
  antrian.printInfo();
}

void inputBarangExport() {
  String namaBarang = ioQuestion("Nama Barang yang mau dimasukkan : ");
  if (namaBarang.isEmpty) {
    return assign.retry(inputBarangExport, "Nama barang tidak boleh kosong");
  }

  String hargaInput = ioQuestion("Harga Barang yang mau dimasukkan : ");
  int? hargaBarang = int.tryParse(hargaInput);
  if (hargaBarang == null) {
    return assign.retry(inputBarangExport,
        "Harga barang harus berupa angka dan tidak boleh kosong");
  }

  String exportBarang = ioQuestion("Export Barang Ke Negara : ");
  if (exportBarang.isEmpty) {
    return assign.retry(
        inputBarangExport, "Export Negara Barang tidak boleh kosong");
  }
  String kategoriBarang = ioQuestion(
      "Kategori Barang yang mau dimasukkan (pisahkan menggunakan koma) : ");
  if (kategoriBarang.isEmpty) {
    return assign.retry(
        inputBarangExport, "Kategori barang tidak boleh kosong");
  }

  antrian.enqueue({
    "namaBarang": namaBarang,
    "hargaBarang": hargaBarang,
    "exportBarang": hargaBarang,
    "kategoriBarang": kategoriBarang
  });

  log.success(
      "Barang \"$namaBarang\" telah ditambahkan ke antrian. Segera cek antrian barang.");
}
