import QtQuick

Item {
    property alias columnNumbers: columnNumbers.spacing
    id: numbersArea
    width: 30; height: mainArea.height
    anchors {left:parent.left; right:mainArea.left; verticalCenter: parent.verticalCenter}

    Rectangle{
        width: parent.width; height:parent.height;

        Column{
            id: columnNumbers
            height: parent.height
            anchors.fill: parent
            spacing:40
            rotation: 180
            clip: true
            Repeater{
                model: 15
                delegate: Text{
                    rotation: 180
                    text: index
                }
            }
        }
    }
}
