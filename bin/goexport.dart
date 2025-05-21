import 'package:goexport/assignment.dart';
import 'package:goexport/doublelinkedlist.dart';
import 'package:goexport/ioselector.dart';
import 'package:goexport/queue.dart';
import 'dart:io';
import 'export.dart';

List<String> mainMenu = ["Export", "Manage", "Exit"];

QueueManual globalAntrian = QueueManual();
HistoryManager globalHistory = HistoryManager();

var welcome = r'''
=======================================================================
   ____         _______  ______   ___  ____ _____      _    ____  ____  
  / ___| ___   | ____\ \/ /  _ \ / _ \|  _ \_   _|    / \  |  _ \|  _ \ 
 | |  _ / _ \  |  _|  \  /| |_) | | | | |_) || |     / _ \ | |_) | |_) |
 | |_| | (_) | | |___ /  \|  __/| |_| |  _ < | |    / ___ \|  __/|  __/ 
  \____|\___/  |_____/_/\_\_|    \___/|_| \_\|_|   /_/   \_\_|   |_|     
=======================================================================
''';

dynamic handleAllMenu() {
  stdout.write("\x1B[2J\x1B[H");
  print(welcome);

  Assignment assign = Assignment();
  int selected = ioselector(mainMenu);
  var a = (selected + 1).toString();

  if (a == "1") {
    return handleExportMenu();
  }

  if (a == "2") {
    globalAntrian.printInfoPusat();
  }

  if (a == "3") {
    exit(1);
  }

  assign.invalidChoose(handleAllMenu);
}

void main() {
  handleAllMenu();
}
