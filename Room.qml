import QtQuick 2.4
import "Constants.js" as UI

Item {
    id: root
    width: UI.grid * 8; height: UI.grid * 6
    opacity: m.pressed ? .5 : 1

    Rectangle {
        id: r
        anchors {fill: parent; margins: -UI.border / 2.0 }
        color: UI.roomColor
        border { color: Qt.darker(UI.roomColor); width: UI.border }

        Rectangle { id: hl; color: Qt.darker(UI.roomColor); visible: !m.pressed }

        MouseArea {
            id: m

            property int rightEdge: root.x + root.width
            property int bottomEdge: root.y + root.height

            width: parent.width
            height: parent.height
            hoverEnabled: true
            drag {
                threshold: 0
                onActiveChanged: {
                    if (!drag.active) {
                        root.x = UI.snap(root.x);
                        root.y = UI.snap(root.y);
                    }
                }
            }

            onContainsMouseChanged: {
                if (!pressed)
                    state = "";
            }

            onPositionChanged: {
                if (!pressed) {
                    if (mouse.x < UI.handle) {
                        state = "left";
                    } else if (mouse.y < UI.handle) {
                        state = "top";
                    } else if (mouse.x > (width - UI.handle)) {
                        state = "right";
                    } else if (mouse.y > (height - UI.handle)) {
                        state = "bottom";
                    } else {
                        state = "";
                    }
                } else {
                    switch (state) {
                    case "left":
                        root.width = (rightEdge - root.x);
                        break;
                    case "right":
                        root.width = Math.max(UI.minimal, mouse.x);
                        break;
                    case "top":
                        root.height = (bottomEdge - root.y);
                        break;
                    case "bottom":
                        root.height = Math.max(UI.minimal, mouse.y);
                        break;
                    }
                }
            }

            onReleased: {
                root.width = UI.snap(root.width);
                root.height = UI.snap(root.height);
                if (!r.contains(mouse))
                    state = "";
                rightEdge = UI.snap(root.x) + root.width;
                bottomEdge = UI.snap(root.y) + root.height;
            }

            states: [
                State {
                    name: ""
                    PropertyChanges { target: hl; width: 0; height: 0; x: 0; y: 0 }
                    PropertyChanges { target: m; drag { target: root; axis: Drag.XAndYAxis } }
                },
                State {
                    name: "left"
                    PropertyChanges { target: hl; width: UI.handle; height: r.height; x: 0; y: 0 }
                    PropertyChanges { target: m; drag { target: root; axis: Drag.XAxis } }
                },
                State {
                    name: "right"
                    PropertyChanges { target: hl; width: UI.handle; height: r.height; x: r.width - UI.handle; y: 0 }
                    PropertyChanges { target: m; drag.target: null }
                },
                State {
                    name: "top"
                    PropertyChanges { target: hl; width: r.width; height: UI.handle; x: 0; y: 0 }
                    PropertyChanges { target: m; drag { target: root; axis: Drag.YAxis } }
                },
                State {
                    name: "bottom"
                    PropertyChanges { target: hl; width: r.width; height: UI.handle; x: 0; y: r.height - UI.handle }
                    PropertyChanges { target: m; drag.target: null }
                }
            ]
        }
    }

    Text {
        anchors.centerIn: parent
        color: Qt.darker(UI.roomColor)
        text: [root.width, root.height].join("x")
    }
}
