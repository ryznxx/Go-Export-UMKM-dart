// unused
import 'dart:collection';

class SaveQueue {
  static final _instance = SaveQueue._internal();
  factory SaveQueue() => _instance;
  SaveQueue._internal();

  final _queue = Queue<Future Function()>();
  bool _isProcessing = false;

  Future<void> add(Future Function() operation) async {
    _queue.add(operation);
    if (!_isProcessing) {
      await _processQueue();
    }
  }

  Future<void> _processQueue() async {
    _isProcessing = true;
    try {
      while (_queue.isNotEmpty) {
        try {
          await _queue.removeFirst()();
        } catch (e) {
          print("Error in save operation: $e");
        }
      }
    } finally {
      _isProcessing = false;
    }
  }
}

final SaveQueue saveQueue = SaveQueue();
