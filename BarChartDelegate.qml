import QtQuick
Row {
            spacing: 10
            height: parent.height
            Text{
                text: model.Users
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
            Repeater{
                model: dayModel
                height: parent.height
                delegate: Rectangle{
                    id:dayBarRect
                    anchors.bottom: parent.bottom
                    width: 30; height: ((day/numbersArea.columnNumbers/*.spacing*/)* parent.height)*3.4 ; color:dayColor
                    Text{
                        anchors.centerIn: parent
                        text: day
                    }
                    ParallelAnimation{
                        running: true
                        PropertyAnimation {
                            id: animation;
                            target: dayBarRect;
                            property: "height";
                            from: 0; to: dayBarRect.height
                            duration: 1000
                        }
                        ColorAnimation {
                            target: dayBarRect
                            property: "color"
                            duration: 2000
                            from: "black"; to: dayColor
                            easing.type: Easing.InOutQuad
                        }

                    }

                }
            }
        }
