import 'package:goexport/extendbinarytree.dart';
import 'package:goexport/iobanner.dart';
import 'package:goexport/ioselector.dart';
import 'export.dart';
import "globals.dart";

List<String> historyMenu = [
  "History Sebelumnya",
  "History Setelahnya",
  // "Node Print"
];

Future<void> handleHistory(BinaryTreeIn distrib) async {
  ioBanner("History Menu");

  if (globalHistory.cekPanjangHistory() != 0) {
    globalHistory.printCurrent();
    print(
        "kamu sekarang di page history ke ${globalHistory.locationNow() + 1}");
    int selected = ioselectorLR();
    var ans = selected;

    if (ans == 1) {
      globalHistory.previous();
      return handleHistory(distrib);
    }

    if (ans == 2) {
      globalHistory.next();
      return handleHistory(distrib);
    }

    if (ans == 3) {
      return handleExportMenu(distrib);
    }

    return assign.invalidChoose(() => handleHistory(distrib));
  } else {
    log.info("History belum tersedia");
    return await assign.nextAction(() => handleExportMenu(distrib));
  }
}
