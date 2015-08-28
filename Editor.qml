import QtQuick 2.4
import QtQuick.Controls 1.3

import "Constants.js" as UI

Rectangle {
    id: root

    Menu {
        id: ctx_menu
        MenuItem {
            text: "add"
            onTriggered: {
                room_component.createObject(map, { x: m.mouseX, y: m.mouseY });
            }
        }
    }

    MouseArea {
        id: m
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onPressed: {
            ctx_menu.popup();
        }
    }

    Image {
        id: grid
        anchors.fill: parent
        source: "grid.png"
        fillMode: Image.Tile
        horizontalAlignment: Image.AlignLeft
        verticalAlignment: Image.AlignTop
        opacity: .3
    }

    Item {
        id: map
        anchors.fill: parent
    }

    Component {
        id: room_component
        Room {}
    }
}
