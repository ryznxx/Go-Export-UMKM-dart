import 'package:goexport/iobanner.dart';
import 'package:goexport/ioselector.dart';
import 'export.dart';
import "goexport.dart";

List<String> historyMenu = [
  "History Sebelumnya",
  "History Setelahnya",
  // "Node Print"
];

void handleHistory() {
  ioBanner("History Menu");

  if (globalHistory.cekPanjangHistory() != 0) {
    globalHistory.printCurrent();
    print(
        "kamu sekarang di page history ke ${globalHistory.locationNow() + 1}");
    int selected = ioselectorLR(handleExportMenu);
    var ans = selected.toString();

    if (ans == "1") {
      globalHistory.previous();
      return handleHistory();
    }
    if (ans == "2") {
      globalHistory.next();
      return handleHistory();
    }

    return assign.invalidChoose(handleHistory);
  } else {
    log.info("History belum tersedia");
  }
}
