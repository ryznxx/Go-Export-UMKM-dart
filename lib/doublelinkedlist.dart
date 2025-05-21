import 'package:cli_table/cli_table.dart';
import 'dart:io';

class HistoryNode<T> {
  T data;
  HistoryNode<T>? next, prev;

  HistoryNode(this.data);
}

class HistoryManager<T> {
  HistoryNode<T>? _current;

  void addHistory(T data) {
    final newNode = HistoryNode<T>(data);

    if (_current != null) {
      newNode.prev = _current;
      _current!.next = newNode;
    }

    _current = newNode;
  }

  T? previous() {
    if (_current?.prev != null) {
      _current = _current!.prev;
      return _current!.data;
    }
    return null;
  }

  T? next() {
    if (_current?.next != null) {
      _current = _current!.next;
      return _current!.data;
    }
    return null;
  }

  T? get current => _current?.data;

  int locationNow() {
    var temp = _current;
    int index = 0;

    while (temp?.prev != null) {
      temp = temp!.prev;
      index++;
    }

    return index;
  }

  void printCurrent() {
    if (_current == null) {
      print("Belum ada history anjim");
    } else {
      var node = _current;
      final data = node!.data as Map<String, dynamic>;

      final table = Table(
        header: [
          'No',
          'Nama Barang',
          "Harga Barang",
          'Domisili Export',
          "Kategori Barang"
        ], // Set headers
        columnWidths: [4, 15, 15, 15, 17], // Optionally set column widhts
        wordWrap: true,
        columnAlignment: [
          HorizontalAlign.center,
          HorizontalAlign.left,
          HorizontalAlign.left,
          HorizontalAlign.left,
          HorizontalAlign.left
        ],
      );

      var items = data["barang"];
      var domisili = data["domisiliExport"];
      for (var i = 0; i < items.length; i++) {
        table.add([
          i + 1,
          items[i]["namaBarang"],
          items[i]["hargaBarang"],
          domisili.toString().isNotEmpty ? domisili : items[i]["exportBarang"],
          items[i]["kategoriBarang"]
        ]);
      }

      print(table.toString());
    }
  }

  void printRope() {
    if (_current == null) {
      print("Belum ada history");
      return;
    }

    var head = _current;
    while (head!.prev != null) {
      head = head.prev;
    }

    stdout.write("\nRIWAYAT HISTORY (dari awal ke paling baru) : ");

    int i = 1;
    while (head != null) {
      stdout.write("[$i]");
      if (head.next != null) {
        stdout.write(" <--> ");
      }
      head = head.next;
      i++;
    }

    print("\n");
  }

  T? cariDanPrintDataHistoryByUrutan(int target) {
    if (target <= 0) return null;

    var node = _current;
    while (node?.prev != null) {
      node = node!.prev;
    }

    int count = 1;
    while (node != null) {
      if (count == target) {
        return node.data;
      }
      node = node.next;
      count++;
    }

    return null;
  }

  int cekPanjangHistory() {
    if (_current == null) return 0;

    HistoryNode<T>? head = _current;
    while (head?.prev != null) {
      head = head!.prev;
    }

    int count = 0;
    HistoryNode<T>? temp = head;
    while (temp != null) {
      count++;
      temp = temp.next;
    }

    return count;
  }
}

String trimOrPad(String input, int maxLen, int padLen) {
  if (input.length > maxLen) {
    return input.substring(0, maxLen);
  } else {
    return input.padRight(padLen);
  }
}

//  void anjat(int target) {
//     if (target <= 0) return;

//     var node = _current;
//     while (node?.prev != null) {
//       node = node!.prev;
//     }

//     int count = 1;
//     while (node != null) {
//       if (count == target) {
//         final data = node.data as List;

//         final table = Table(
//           header: [
//             'No',
//             'Nama Barang',
//             "Harga Barang",
//             "Kategori Barang"
//           ], // Set headers
//           columnWidths: [5, 20, 20, 22], // Optionally set column widhts
//           wordWrap: true,
//           columnAlignment: [
//             HorizontalAlign.center,
//             HorizontalAlign.left,
//             HorizontalAlign.left,
//             HorizontalAlign.left
//           ],
//         );

//         for (var i = 0; i < data.length; i++) {
//           table.add([
//             i + 1,
//             data[i]["namaBarang"],
//             data[i]["hargaBarang"],
//             data[i]["kategoriBarang"]
//           ]);
//         }

//         print(table.toString());
//         return;
//       }
//       node = node.next;
//       count++;
//     }
//   }
