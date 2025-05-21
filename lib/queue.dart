import 'package:dart_console/dart_console.dart';
import 'dart:convert';
import 'package:cli_table/cli_table.dart' as tub;
import 'package:goexport/log.dart';

Logging log = Logging();

class Node<T> {
  T data;
  Node<T>? next;

  Node(this.data);
}

class QueueManual<T> {
  Node<T>? _front;
  Node<T>? _rear;
  int _length = 0;

  void transferQueue(QueueManual<T> targetQueue) {
    while (!isEmpty) {
      targetQueue.enqueue(dequeue());
    }
  }

  void enqueue(T item) {
    final newNode = Node(item);
    if (_rear != null) {
      _rear!.next = newNode;
    } else {
      _front = newNode;
    }
    _rear = newNode;
    _length++;
  }

  T dequeue() {
    final data = _front!.data;
    if (_front == null) {
      log.info("Antrian kosong");
    }
    _front = _front!.next;
    if (_front == null) _rear = null;
    _length--;
    return data;
  }

  T peek() {
    if (_front == null) throw Exception("Antrian kosong");
    return _front!.data;
  }

  bool get isEmpty => _length == 0;
  int get length => _length;

  void printInfo() {
    final console = Console();
    if (isEmpty) {
      console.setForegroundColor(ConsoleColor.red);
      console.writeLine('Antrian kosong.');
      console.resetColorAttributes();
    } else {
      var current = _front;
      final dataList = <T>[];

      while (current != null) {
        dataList.add(current.data);
        current = current.next;
      }

      final tableds = tub.Table(
        header: [
          'No',
          'Nama Barang',
          "Harga Barang",
          "Export Barang",
          "Kategori Barang"
        ], // Set headers
        columnWidths: [4, 15, 15, 15, 17], // Optionally set column widhts
        wordWrap: true,
        columnAlignment: [
          tub.HorizontalAlign.center,
          tub.HorizontalAlign.left,
          tub.HorizontalAlign.left,
          tub.HorizontalAlign.left,
          tub.HorizontalAlign.left
        ],
      );

      console.setForegroundColor(ConsoleColor.blue);
      console.writeLine('                          Isi Didalam Antrian');
      console.writeLine(
          '=======================================================================\n');
      console.resetColorAttributes();

      for (var i = 0; i < dataList.length; i++) {
        var item = dataList[i] as Map<String, dynamic>;
        tableds.add([
          i + 1,
          item["namaBarang"],
          item["hargaBarang"],
          item["exportBarang"],
          item["kategoriBarang"]
        ]);
      }
      print(tableds.toString());
      var checked = _front!.data as Map<String, dynamic>;
      console.setForegroundColor(ConsoleColor.magenta);
      console.writeLine("\nJumlah antrian: $length");
      console.writeLine("Item paling depan: ${checked["namaBarang"]}");
      console.resetColorAttributes();
    }
  }

  void printInfoPusat() {
    final console = Console();
    if (isEmpty) {
      console.setForegroundColor(ConsoleColor.red);
      console.writeLine('Antrian kosong.');
      console.resetColorAttributes();
    } else {
      var current = _front;
      final dataList = <T>[];

      while (current != null) {
        dataList.add(current.data);
        current = current.next;
      }

      final tableds = tub.Table(
        header: [
          'No',
          'Nama Barang',
          "Harga Barang",
          "Export Barang",
          "Kategori Barang"
        ], // Set headers
        columnWidths: [4, 15, 15, 15, 17], // Optionally set column widhts
        wordWrap: true,
        columnAlignment: [
          tub.HorizontalAlign.center,
          tub.HorizontalAlign.left,
          tub.HorizontalAlign.left,
          tub.HorizontalAlign.left,
          tub.HorizontalAlign.left
        ],
      );

      console.setForegroundColor(ConsoleColor.blue);
      console.writeLine('                      Isi Didalam Antrian Pusat');
      console.writeLine(
          '=======================================================================\n');
      console.resetColorAttributes();

      for (var i = 0; i < dataList.length; i++) {
        var item = dataList[i] as Map<String, dynamic>;
        tableds.add([
          i + 1,
          item["namaBarang"],
          item["hargaBarang"],
          item["exportBarang"],
          item["kategoriBarang"]
        ]);
      }
      print(tableds.toString());
      var checked = _front!.data as Map<String, dynamic>;
      console.setForegroundColor(ConsoleColor.magenta);
      console.writeLine("\nJumlah antrian: $length");
      console.writeLine("Item paling depan: ${checked["namaBarang"]}");
      console.resetColorAttributes();
    }
  }

  String fullContent() {
    var current = _front;
    List<String> items = [];

    while (current != null) {
      items.add(current.data.toString());
      current = current.next;
    }

    return items.join('\n');
  }

  List<Map<String, dynamic>> fullContentList() {
    var current = _front;
    List<Map<String, dynamic>> items = [];

    while (current != null) {
      dynamic raw = current.data;

      if (raw is String) {
        try {
          var decoded = jsonDecode(raw);
          if (decoded is Map<String, dynamic>) {
            items.add(decoded);
          } else {
            print("⚠️ DATA DI DALAMNYA BUKAN MAP: $decoded");
          }
        } catch (e) {
          print("❌ GAGAL PARSING JSON: $e");
        }
      } else if (raw is Map<String, dynamic>) {
        items.add(raw);
      } else {
        print("💩 DATA GAK BISA DIPAKE: $raw");
      }

      current = current.next;
    }

    return items;
  }
}

class Barang {
  final String namaBarang;
  final int hargaBarang;
  final String kategoriBarang;

  Barang(this.namaBarang, this.hargaBarang, this.kategoriBarang);

  Map<String, dynamic> toMap() {
    return {
      'namaBarang': namaBarang,
      'hargaBarang': hargaBarang,
      'kategoriBarang': kategoriBarang,
    };
  }
}
