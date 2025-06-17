import 'dart:convert';

class TreeNode<T> {
  T data;
  List<TreeNode<T>> children = []; // List untuk menyimpan banyak child

  TreeNode(this.data);

  void addChild(TreeNode<T> child) {
    children.add(child);
  }
}

class Tuple2<A, B> {
  final A item1;
  final B item2;

  Tuple2(this.item1, this.item2);
}

class BinaryTree<T> {
  TreeNode<T>? root;
  late bool isFirstPrint = true;

  Future<void> Function()? onTreeChanged;

  void addRoot(T data) {
    if (root != null) {
      throw Exception("Root sudah ada!");
    }
    root = TreeNode(data);
  }

  /// Menambahkan child ke parent tertentu
  bool addChild(T parentData, T childData) {
    if (root == null) return false;
    final parentNode = _findNode(root!, parentData);
    if (parentNode == null) return false;

    parentNode.addChild(TreeNode(childData));
    return true;
  }

  /// Mencari node berdasarkan data (DFS)
  TreeNode<T>? _findNode(TreeNode<T> node, T data) {
    if (node.data == data) return node;

    for (final child in node.children) {
      final found = _findNode(child, data);
      if (found != null) return found;
    }

    return null;
  }

  bool hasChild(T data) {
    var node = root!;

    if (node.data == data) return false;

    for (final child in node.children) {
      final found = _findNode(child, data);
      if (found != null) return true;
    }

    return false;
  }

  bool findSimilarChildAndReplace(bool Function(T) comparator, T newData) {
    if (root == null) return false;

    bool findAndReplace(TreeNode<T> node) {
      for (int i = 0; i < node.children.length; i++) {
        final child = node.children[i];
        if (comparator(child.data)) {
          node.children[i] = TreeNode(newData);
          return true;
        }

        if (findAndReplace(child)) {
          return true;
        }
      }

      return false;
    }

    return findAndReplace(root!);
  }

  bool moveChild(T childData, T newParentData) {
    if (root == null) return false;

    final parentAndChild = _findParentAndChild(root!, null, childData);
    if (parentAndChild == null) return false;

    final oldParent = parentAndChild.item1;
    final childNode = parentAndChild.item2;

    if (oldParent != null) {
      oldParent.children.remove(childNode);
    } else {
      return false;
    }

    final newParentNode = _findNode(root!, newParentData);
    if (newParentNode == null) return false;

    newParentNode.children.add(childNode);

    return true;
  }

  Tuple2<TreeNode<T>?, TreeNode<T>>? _findParentAndChild(
      TreeNode<T> current, TreeNode<T>? parent, T targetData) {
    if (current.data == targetData) {
      return Tuple2(parent, current);
    }

    for (final child in current.children) {
      final result = _findParentAndChild(child, current, targetData);
      if (result != null) return result;
    }

    return null;
  }

  bool remove(T data) {
    if (root == null) return false;
    if (root!.data == data) {
      root = null;
      return true;
    }
    if (_removeNode(root!, data)) {
      return true;
    }
    return false;
  }

  bool _removeNode(TreeNode<T> parent, T data) {
    for (int i = 0; i < parent.children.length; i++) {
      final child = parent.children[i];
      if (child.data == data) {
        parent.children.removeAt(i);
        return true;
      }
      if (_removeNode(child, data)) return true;
    }
    return false;
  }

  void printTree([TreeNode<T>? node, String prefix = '', bool isLast = true]) {
    node ??= root;
    if (node == null) {
      print("🌳 [EMPTY] Tree belum diinisialisasi.");
      return;
    }

    String display = node.data.toString();

    if (_isJsonMapString(display)) {
      try {
        final decoded = jsonDecode(display);
        if (decoded is Map<String, dynamic>) {
          display = decoded['namaBarang']?.toString() ?? '[NO namaBarang]';
        } else {
          display = '[NOT A MAP]';
        }
      } catch (e) {
        display = '[INVALID JSON]';
      }
    }

    print(
        "$prefix${isLast ? "└── " : "├── "}$display${node.children.isEmpty ? " 🗁  [LEAF]" : ""}");

    for (int i = 0; i < node.children.length; i++) {
      final isLastChild = i == node.children.length - 1;
      printTree(
          node.children[i], "$prefix${isLast ? "    " : "│   "}", isLastChild);
    }
  }

  String? extractNamaBarang([String? rotten]) {
    if (rotten == null || rotten.trim().isEmpty) return null;

    if (_isJsonMapString(rotten)) {
      try {
        final decoded = jsonDecode(rotten);
        if (decoded is Map<String, dynamic>) {
          return decoded['namaBarang']?.toString();
        }
      } catch (_) {
        return rotten;
      }
    }

    return rotten;
  }

  String? extractDomisiliBarang([String? rotten]) {
    if (rotten == null || rotten.trim().isEmpty) return null;

    if (_isJsonMapString(rotten)) {
      try {
        final decoded = jsonDecode(rotten);
        if (decoded is Map<String, dynamic>) {
          final exp = decoded['dataSpesifik']['exportBarang'];
          return (exp != null && exp.toString().trim().isNotEmpty)
              ? exp.toString()
              : null;
        }
      } catch (_) {}
    }

    return null;
  }

  // void changeExportLocation(void Function(T) visit, [TreeNode<T>? node]) {
  //   node ??= root;
  //   if (node == null) return;
  //   try {
  //     visit(node.data);
  //     for (final child in node.children) {
  //       preOrder(visit, child);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  bool _isJsonMapString(String str) {
    str = str.trim();
    if (!str.startsWith("{") || !str.endsWith("}")) return false;

    try {
      final decoded = jsonDecode(str);
      return decoded is Map<String, dynamic>;
    } catch (_) {
      return false;
    }
  }

  /// Pre-order traversal: Parent → Children (dari kiri)
  void preOrder(void Function(T) visit, [TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return;

    visit(node.data); // Kunjungi parent terlebih dahulu
    for (final child in node.children) {
      preOrder(visit, child); // Rekursif ke semua children
    }
  }

  /// Post-order traversal: Children (dari kiri) → Parent
  void postOrder(void Function(T) visit, [TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return;

    for (final child in node.children) {
      postOrder(visit, child); // Rekursif ke children dulu
    }
    visit(node.data); // Baru kunjungi parent
  }

  /// In-order traversal: Child pertama → Parent → Child lainnya
  void inOrder(void Function(T) visit, [TreeNode<T>? node]) {
    node ??= root;
    if (node == null) return;

    if (node.children.isNotEmpty) {
      inOrder(visit, node.children.first); // Kunjungi child pertama
    }
    visit(node.data); // Kunjungi parent
    for (final child in node.children.skip(1)) {
      inOrder(visit, child); // Kunjungi child lainnya
    }
  }

  bool rootIsFilled() {
    if (root!.data == null) {
      return false;
    }

    return true;
  }
}
