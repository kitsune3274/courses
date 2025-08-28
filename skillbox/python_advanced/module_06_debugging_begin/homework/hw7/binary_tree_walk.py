"""
Помимо того чтобы логи писать, нужно их ещё и уметь читать,
иначе мы будем как в известном анекдоте, писателями, а не читателями.

Для вас мы написали простую функцию обхода binary tree по уровням.
Также в репозитории есть файл с логами, написанными этой программой.

Напишите функцию restore_tree, которая принимает на вход путь до файла с логами
    и восстанавливать исходное BinaryTree.

Функция должна возвращать корень восстановленного дерева

def restore_tree(path_to_log_file: str) -> BinaryTreeNode:
    pass

Примечание: гарантируется, что все значения, хранящиеся в бинарном дереве уникальны
"""
import itertools
import logging
import random
from collections import deque
from dataclasses import dataclass
from idlelib.outwin import file_line_pats
from typing import Optional

logger = logging.getLogger("tree_walk")


@dataclass
class BinaryTreeNode:
    val: int
    left: Optional["BinaryTreeNode"] = None
    right: Optional["BinaryTreeNode"] = None

    def __repr__(self):
        return f"<BinaryTreeNode[{self.val}]>"


def walk(root: BinaryTreeNode):
    queue = deque([root])

    while queue:
        node = queue.popleft()

        logger.info(f"Visiting {node!r}")

        if node.left:
            logger.debug(
                f"{node!r} left is not empty. Adding {node.left!r} to the queue"
            )
            queue.append(node.left)

        if node.right:
            logger.debug(
                f"{node!r} right is not empty. Adding {node.right!r} to the queue"
            )
            queue.append(node.right)


counter = itertools.count(random.randint(1, 10 ** 6))


def get_tree(max_depth: int, level: int = 1) -> Optional[BinaryTreeNode]:
    if max_depth == 0:
        return None

    node_left = get_tree(max_depth - 1, level=level + 1)
    node_right = get_tree(max_depth - 1, level=level + 1)
    node = BinaryTreeNode(val=next(counter), left=node_left, right=node_right)

    return node

import re
def restore_tree(path_to_log_file: str) -> BinaryTreeNode:
    """
    Восстановление бинарного дерева
    Parameters:
        path_to_log_file: str
            файл с логами о дереве
    Returns:
        корень бинарного дерева
    """
    with open(path_to_log_file, 'r') as file:

        file_list = file.readlines()
        # чистим считанную строку от всех символов и букв, оставляя только число(-а)
        reg = re.compile('[^0-9 ]')
        # разделяем строку на элементы
        num_list_for_root = reg.sub('', file_list[0]).split()
        # считываем цифру
        root_num = int(num_list_for_root[0])

        root = BinaryTreeNode(val=root_num, left=None, right=None)
        tree = {}
        node_left = None
        
        for line in file_list:
            num_list = reg.sub('', line).split()
            if line.startswith("INFO"):
                node_num = int(num_list[0])
                tree[node_num] = BinaryTreeNode(val=node_num)
            elif line.startswith("DEBUG") and 'left' in line:
                node_left = int(num_list[1])
                tree[node_num] = BinaryTreeNode(val=node_num, left=BinaryTreeNode(node_left), right= None)
            elif line.startswith("DEBUG") and 'right' in line:
                node_right = int(num_list[1])
                if node_left:
                    tree[node_num] = BinaryTreeNode(
                        val=node_num, left=BinaryTreeNode(node_left), right=BinaryTreeNode(node_right)
                    )
                else:
                    tree[node_num] = BinaryTreeNode(
                        val=node_num, left=None, right=BinaryTreeNode(node_right)
                    )
        # print(f"Узел: {tree[796149]}, левый: {tree[796149].left}, правый: {tree[796149].right}")
        return root


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.DEBUG,
        format="%(levelname)s:%(message)s",
        filename="walk_log_4.txt",
    )

    root = get_tree(7)
    walk(root)
    print(restore_tree("walk_log_1.txt"))
    print(restore_tree("walk_log_2.txt"))
    print(restore_tree("walk_log_3.txt"))
    print(restore_tree("walk_log_4.txt"))