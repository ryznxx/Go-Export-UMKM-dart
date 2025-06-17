import 'dart:convert';

Map? ambilYangMap(List ch) {
  for (var item in ch) {
    if (item is Map) {
      print('MAP LANGSUNG: $item');
    } else if (item is String) {
      try {
        var decoded = jsonDecode(item);
        if (decoded is Map) {
          print('DARI JSON STRING: $decoded');
          return decoded;
        }
      } catch (e) {
        // cuek aja, skip error
      }
    }
  }
  return null;
}

Map<String, dynamic>? parseToMap(dynamic item) {
  if (item is Map<String, dynamic>) return item;

  if (item is String) {
    try {
      final decoded = jsonDecode(item);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      // skip item yang ga bisa di-decode
    }
  }

  return null;
}
