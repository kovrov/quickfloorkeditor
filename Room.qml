import QtQuick 2.4
import "Constants.js" as UI

Item {
    id: root
    width: UI.grid * 8; height: UI.grid * 6
    opacity: m.pressed ? .5 : 1

    Rectangle {
        anchors {fill: parent; margins: -2 }
        color: UI.roomColor
        border { color: Qt.darker(UI.roomColor); width: 4 }
    }

    MouseArea {
        anchors.fill: parent
        drag {
            target: parent
            onActiveChanged: {
                parent.x = UI.snap(parent.x);
                parent.y = UI.snap(parent.y);
            }
        }
    }

    Rectangle {
        anchors { right: parent.right; bottom: parent.bottom; }
        width: UI.handle; height: UI.handle
        color: Qt.darker(UI.roomColor)
    }

    MouseArea {
        id: m
        width: UI.handle; height: UI.handle
        Component.onCompleted: {
            x = parent.width - UI.handle;
            y = parent.height - UI.handle;
        }
        onPositionChanged: {
            var g = mapToItem(root, mouse.x, mouse.y);
            root.width = Math.max(UI.minimal, g.x + UI.handle / 2);
            root.height = Math.max(UI.minimal, g.y + UI.handle / 2);
        }
        onReleased: {
            root.width = UI.snap(root.width);
            root.height = UI.snap(root.height);
            x = parent.width - UI.handle;
            y = parent.height - UI.handle;
        }
    }
}
