import 'package:dart_console/dart_console.dart';

class Logging {
  final Console _console = Console();

  void error(String text) {
    _console.setForegroundColor(ConsoleColor.red);
    _console.writeLine('[ERROR] $text');
    _console.resetColorAttributes();
  }

  void info(String text) {
    _console.setForegroundColor(ConsoleColor.brightBlue);
    _console.writeLine('[INFO] $text');
    _console.resetColorAttributes();
  }

  void success(String text) {
    _console.setForegroundColor(ConsoleColor.green);
    _console.writeLine('[SUCCESS] $text');
    _console.resetColorAttributes();
  }

  void warning(String text) {
    _console.setForegroundColor(ConsoleColor.yellow);
    _console.writeLine('[SUCCESS] $text');
    _console.resetColorAttributes();
  }
}
