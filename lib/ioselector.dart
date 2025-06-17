import 'dart:io';
import 'package:dart_console/dart_console.dart';

int ioselector(List<String> menu) {
  final console = Console();
  console.writeLine(
      "Pilih menu pake panah ATAS/BAWAH, tekan BACKSPACE buat keluar\n");
  int i = 0;
  final topRow = console.cursorPosition!.row;

  while (true) {
    for (int j = 0; j < menu.length; j++) {
      console.cursorPosition = Coordinate(topRow + j, 0);
      if (j == i) {
        console.setForegroundColor(ConsoleColor.brightGreen);
        console.write('🡺  ');
        console.setForegroundColor(ConsoleColor.yellow);
        console.hideCursor();
      } else {
        console.write('   ');
        console.setForegroundColor(ConsoleColor.white);
      }
      console.write(menu[j]);
      console.write(' ' * (20 - menu[j].length));
      console.resetColorAttributes();
    }

    final key = console.readKey();

    if (key.controlChar == ControlCharacter.backspace) {
      console.cursorPosition = Coordinate(topRow + menu.length + 1, 0);
      console.setForegroundColor(ConsoleColor.red);
      print('Keluar Program...');
      console.showCursor();
      exit(1);
    }

    if (key.controlChar == ControlCharacter.arrowUp) {
      i = (i - 1 + menu.length) % menu.length;
    } else if (key.controlChar == ControlCharacter.arrowDown) {
      i = (i + 1) % menu.length;
    } else if (key.controlChar == ControlCharacter.enter) {
      console.cursorPosition = Coordinate(topRow + menu.length + 2, 0);
      console.resetColorAttributes();
      console.showCursor();
      return i;
    }
  }
}

int iopicker(List<String> menu) {
  final console = Console();
  console
      .writeLine("Pilih pake panah ATAS/BAWAH, tekan BACKSPACE buat keluar\n");
  int i = 0;
  final topRow = console.cursorPosition!.row;

  while (true) {
    for (int j = 0; j < menu.length; j++) {
      console.cursorPosition = Coordinate(topRow + j, 0);
      if (j == i) {
        console.setForegroundColor(ConsoleColor.brightGreen);
        console.write('🡺  ');
        console.setForegroundColor(ConsoleColor.yellow);
        console.hideCursor();
      } else {
        console.write('   ');
        console.setForegroundColor(ConsoleColor.white);
      }
      console.write(menu[j]);
      console.write(' ' * (20 - menu[j].length));
      console.resetColorAttributes();
    }

    final key = console.readKey();

    if (key.controlChar == ControlCharacter.backspace) {
      console.cursorPosition = Coordinate(topRow + menu.length + 1, 0);
      console.setForegroundColor(ConsoleColor.red);
      print('Keluar Program...');
      console.showCursor();
      exit(1);
    }

    if (key.controlChar == ControlCharacter.arrowUp) {
      i = (i - 1 + menu.length) % menu.length;
    } else if (key.controlChar == ControlCharacter.arrowDown) {
      i = (i + 1) % menu.length;
    } else if (key.controlChar == ControlCharacter.enter) {
      console.cursorPosition = Coordinate(topRow + menu.length + 2, 0);
      console.resetColorAttributes();
      console.showCursor();
      return i;
    }
  }
}

int ioselectorPretty(List<String> menu) {
  final console = Console();
  console.writeLine(
      "Pilih menu pake panah ATAS/BAWAH, tekan BACKSPACE buat keluar\n");

  int i = 0;
  console.writeLine('╭─ Menu');

  final topRow = console.cursorPosition!.row;

  while (true) {
    for (int j = 0; j < menu.length; j++) {
      console.cursorPosition = Coordinate(topRow + j, 0);

      if (j == i) {
        console.setForegroundColor(ConsoleColor.brightGreen);
        console.write('╰─▶ •  ');
        console.setForegroundColor(ConsoleColor.yellow);
        console.hideCursor();
      } else {
        console.setForegroundColor(ConsoleColor.white);

        if (j == i + 1 || j == menu.length - 1) {
          console.write('    •  ');
        } else {
          console.write('│   •  ');
        }
      }

      console.write(menu[j]);
      console.write(' ' * (20 - menu[j].length));
      console.resetColorAttributes();
    }

    final key = console.readKey();

    if (key.controlChar == ControlCharacter.backspace) {
      console.cursorPosition = Coordinate(topRow + menu.length + 1, 0);
      console.setForegroundColor(ConsoleColor.red);
      print('Keluar Program...');
      console.showCursor();
      exit(1);
    }

    if (key.controlChar == ControlCharacter.arrowUp) {
      i = (i - 1 + menu.length) % menu.length;
    } else if (key.controlChar == ControlCharacter.arrowDown) {
      i = (i + 1) % menu.length;
    } else if (key.controlChar == ControlCharacter.enter) {
      console.cursorPosition = Coordinate(topRow + menu.length + 2, 0);
      console.resetColorAttributes();
      console.showCursor();
      return i;
    }
  }
}

int ioselectorLR() {
  final console = Console();
  console.writeLine(
      "Pilih menu pake panah KIRI/KANAN, tekan BACKSPACE buat keluar\n");
  final topRow = console.cursorPosition!.row;

  while (true) {
    console.cursorPosition = Coordinate(topRow, 0);

    final key = console.readKey();

    if (key.controlChar == ControlCharacter.backspace) {
      return 3;
    }

    if (key.controlChar == ControlCharacter.arrowLeft) {
      return 1;
    } else if (key.controlChar == ControlCharacter.arrowRight) {
      return 2;
    }
  }
}
