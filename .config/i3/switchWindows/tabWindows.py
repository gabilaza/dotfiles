import json
import subprocess

GET_TREE_COMMAND = 'i3-msg -t get_tree'


def executeCommand(command):
    output = b''
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in p.stdout.readlines():
        output += line.strip()
    return output


def checkFocusedWindowInWorkspace(root):
    if "nodes" in root and len(root["nodes"]) > 0:
        for node in root["nodes"]:
            if checkFocusedWindowInWorkspace(node):
                return True
    if 'floating_nodes' in root and len(root['floating_nodes']) > 0:
        for node in root['floating_nodes']:
            if checkFocusedWindowInWorkspace(node):
                return True
    if root['window'] is not None and root['focused']:
        return True
    return False


def findCurrentWorkspace(root):
    if root['type'] == 'workspace':
        if checkFocusedWindowInWorkspace(root):
            return root
    elif "nodes" in root and len(root["nodes"]) > 0:
        for node in root["nodes"]:
            workspace = findCurrentWorkspace(node)
            if workspace:
                return workspace
    return None


def findWindows(root, windowList):
    if root['window'] is not None:
        windowList.append(root)
    if "nodes" in root and len(root["nodes"]) > 0:
        for node in root["nodes"]:
            findWindows(node, windowList)
    if 'floating_nodes' in root and len(root['floating_nodes']) > 0:
        for node in root['floating_nodes']:
            findWindows(node, windowList)


def getNextWindow(windowList):
    if windowList:
        for i, window in enumerate(windowList[:-1]):
            if window["focused"]:
                return windowList[i+1]['window']
        return windowList[0]['window']
    return None


def main():
    output = executeCommand(GET_TREE_COMMAND)
    tree = json.loads(output)

    currentWorkspaceTree = findCurrentWorkspace(tree)

    if currentWorkspaceTree:
        windowList = []
        findWindows(currentWorkspaceTree, windowList)
        nextWindowId = getNextWindow(windowList)
        if nextWindowId:
            print(nextWindowId)


if __name__ == '__main__':
    main()

