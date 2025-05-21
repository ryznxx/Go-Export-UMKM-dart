import 'package:goexport/ioplate.dart';
import 'dart:io';

class Assignment {
  void showMenu(List menu) {
    if (menu.isEmpty) return;

    for (var i = 0; i < menu.length; i++) {
      print("${i + 1}. ${menu[i]}");
    }
  }

  void showMenuWithText(List menu, String text) {
    if (menu.isEmpty) return;

    stdout.write("\x1B[2J\x1B[H");
    print(text);

    for (var i = 0; i < menu.length; i++) {
      print("${i + 1}. ${menu[i]}");
    }
  }

  void showMenuWithBack(List<String> menu) {
    if (menu.isEmpty) return;

    for (var i = 0; i < menu.length + 1; i++) {
      if (i < menu.length) {
        print("${i + 1}. ${menu[i]}");
      } else {
        print("${i + 1}. Kembali ke menu sebelumnya");
      }
    }
  }

  void invalidChoose(dynamic action) {
    String answer =
        ioQuestion("\nPilihan opsi tidak valid, tekan enter untuk ulang.. ");

    if (answer.isEmpty) {
      action();
    }

    if (answer.isNotEmpty) {
      invalidChoose(action);
    }
  }

  void nextAction(dynamic action) {
    String answer = ioQuestion("\ntekan enter untuk melanjutkan.. ");

    if (answer.isEmpty) {
      action();
    }

    if (answer.isNotEmpty) {
      nextAction(action);
    }
  }

  void retry(dynamic action, String message) {
    String answer = ioQuestion("\n$message, tekan enter untuk mengulangi.. ");

    if (answer.isEmpty) {
      action();
    }

    if (answer.isNotEmpty) {
      retry(action, message);
    }
  }
}
