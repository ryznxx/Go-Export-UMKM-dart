import 'dart:io';

void ioBanner(String text) {
  stdout.write("\x1B[2J\x1B[H");

  const int totalWidth = 71; // Jumlah karakter =====...===== (1 baris banner)
  const String border = '=';

  String welcome = r'''
=======================================================================

    ____           _____                       _       ____ _     ___ 
   / ___| ___     | ____|_  ___ __   ___  _ __| |_    / ___| |   |_ _|
  | |  _ / _ \    |  _| \ \/ / '_ \ / _ \| '__| __|  | |   | |    | | 
  | |_| | (_) |   | |___ >  <| |_) | (_) | |  | |_   | |___| |___ | | 
   \____|\___/    |_____/_/\_\ .__/ \___/|_|   \__|   \____|_____|___|
                             |_|                                        
=======================================================================
''';

  // Hitung padding kiri dan kanan buat teks biar center
  int padding = ((totalWidth - text.length) / 2).floor();
  String centeredText = '${' ' * padding}$text';

  print('''$welcome$centeredText\n${border * totalWidth}\n''');
}

void ioCls() {
  stdout.write("\x1B[2J\x1B[H");
}
