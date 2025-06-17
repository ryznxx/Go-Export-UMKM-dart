import 'dart:convert';
import 'dart:io';
import 'binarytree.dart';

class BinaryTreeIn<T> extends BinaryTree<T> {
  // String? _autoSavePath; // Path auto-save

  void syncTo(BinaryTree<T> target) {
    target.root = _deepCopy(root);
  }

  TreeNode<T>? _deepCopy(TreeNode<T>? node) {
    if (node == null) return null;
    final newNode = TreeNode<T>(node.data);
    newNode.children
        .addAll(node.children.map(_deepCopy).whereType<TreeNode<T>>());
    return newNode;
  }

  /// Convert tree to JSON-compatible Map
  Map<String, dynamic> saveToJson() {
    return {
      'root': _nodeToJson(root),
      'type': T.toString(),
    };
  }

  /// Helper: Convert TreeNode to JSON
  Map<String, dynamic>? _nodeToJson(TreeNode<T>? node) {
    if (node == null) return null;

    dynamic data;
    try {
      if (node.data is String) {
        try {
          data = jsonDecode(node.data as String);
        } catch (_) {
          data = node.data;
        }
      } else if (node.data is Map) {
        data = node.data;
      } else {
        data = node.data.toString();
      }

      return {
        'data': data,
        'children': node.children.map(_nodeToJson).toList(),
      };
    } catch (e) {
      throw Exception("Failed to serialize node: $e");
    }
  }

  /// Save JSON to file
  Future<void> saveToFile(String filePath) async {
    final jsonData = saveToJson();
    final file = File(filePath);
    await file.writeAsString(jsonEncode(jsonData));
  }

  /// Restore tree from JSON
  void restoreFromJson(Map<String, dynamic> json) {
    try {
      if (json['type'] != T.toString()) {
        throw ArgumentError('Type mismatch: Expected ${T.toString()}');
      }

      root = _jsonToNode(json['root']);
    } catch (e) {
      throw Exception("Failed to restore from JSON: $e");
    }
  }

  /// Helper: Convert JSON to TreeNode
  TreeNode<T>? _jsonToNode(Map<String, dynamic>? json) {
    if (json == null) return null;

    try {
      dynamic data = json['data'];
      T nodeData;

      if (T == String) {
        if (data is Map) {
          nodeData = jsonEncode(data) as T;
        } else {
          nodeData = data.toString() as T;
        }
      } else {
        nodeData = data as T;
      }

      final node = TreeNode<T>(nodeData);
      if (json['children'] != null) {
        final children = json['children'] as List;
        node.children.addAll(
          children.map((child) => _jsonToNode(child)).whereType<TreeNode<T>>(),
        );
      }
      return node;
    } catch (e) {
      throw Exception("Failed to deserialize node: $e");
    }
  }

  /// Restore from file
  Future<void> restoreFromFile(String filePath) async {
    final file = File(filePath);
    final jsonString = await file.readAsString();
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    restoreFromJson(jsonData);
  }

  String toJson() {
    if (root == null) {
      return '{}'; // Atau 'null' atau String kosong, tergantung kebutuhan representasi tree kosong
    }

    try {
      final Map<String, dynamic>? treeMap = _nodeToJson(root);
      return jsonEncode(treeMap);
    } catch (e) {
      rethrow; // Biarkan error ditangani oleh pemanggil
    }
  }
}
