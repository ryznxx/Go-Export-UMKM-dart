class BinaryTreeNode<T> {
  T data;
  BinaryTreeNode<T>? left, right;

  BinaryTreeNode(this.data);
}

class BinaryTree<T> {
  BinaryTreeNode<T>? root;

  void addRoot(T data) {
    if (root != null) {
      throw Exception("Root udah ada woi");
    }
    root = BinaryTreeNode(data);
  }

  bool addChild(T parentData, T childData) {
    final parentNode = _findNode(root, parentData);
    if (parentNode == null) return false;

    if (parentNode.left == null) {
      parentNode.left = BinaryTreeNode(childData);
      return true;
    } else if (parentNode.right == null) {
      parentNode.right = BinaryTreeNode(childData);
      return true;
    } else {
      return false;
    }
  }

  bool remove(T targetData) {
    if (root == null) return false;
    if (root!.data == targetData) {
      root = null;
      return true;
    }
    return _removeNode(root, targetData);
  }

  BinaryTreeNode<T>? _findNode(BinaryTreeNode<T>? node, T data) {
    if (node == null) return null;
    if (node.data == data) return node;

    final leftResult = _findNode(node.left, data);
    if (leftResult != null) return leftResult;

    return _findNode(node.right, data);
  }

  bool _removeNode(BinaryTreeNode<T>? node, T data) {
    if (node == null) return false;

    if (node.left != null && node.left!.data == data) {
      node.left = null;
      return true;
    }

    if (node.right != null && node.right!.data == data) {
      node.right = null;
      return true;
    }

    return _removeNode(node.left, data) || _removeNode(node.right, data);
  }

  void inOrder(BinaryTreeNode<T>? node, void Function(T) visit) {
    if (node == null) return;
    inOrder(node.left, visit);
    visit(node.data);
    inOrder(node.right, visit);
  }

  void preOrder(BinaryTreeNode<T>? node, void Function(T) visit) {
    if (node == null) return;
    visit(node.data);
    preOrder(node.left, visit);
    preOrder(node.right, visit);
  }

  void postOrder(BinaryTreeNode<T>? node, void Function(T) visit) {
    if (node == null) return;
    postOrder(node.left, visit);
    postOrder(node.right, visit);
    visit(node.data);
  }

  void printTree(
      [BinaryTreeNode<T>? node, String prefix = '', bool isLeft = true]) {
    node ??= root;
    if (node == null) return;

    if (node.right != null) {
      printTree(node.right, "$prefix${isLeft ? "│   " : "    "}", false);
    }

    print("$prefix${isLeft ? "└── " : "┌── "}${node.data}");

    if (node.left != null) {
      printTree(node.left, "$prefix${isLeft ? "    " : "│   "}", true);
    }
  }
}
