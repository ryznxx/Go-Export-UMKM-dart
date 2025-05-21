import 'package:dart_console/dart_console.dart';

final console = Console();
String ioQuestion(String question) {
  if (question.isNotEmpty) {
    console.write(question);
    String ioRead = console.readLine()!;
    return ioRead;
  }
  return "";
}

String ioChooseOption(int total) {
  print("");
  console.write("Pilih Opsi (1 - $total) : ");
  String ioRead = console.readLine()!;
  return ioRead;
}
