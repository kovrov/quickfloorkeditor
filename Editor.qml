import QtQuick 2.4
import "Constants.js" as UI

Rectangle {

    Item {
        id: map
        anchors.fill: parent
    }

    Component {
        id: room_component
        Room {}
    }

    MouseArea {
        width: UI.button.width; height: UI.button.height
        Rectangle { anchors.fill: parent }
        Text { text: "+"; anchors.centerIn: parent }
        onClicked: {
            room_component.createObject(map, { x: 32, y: 32 });
        }
    }
}
