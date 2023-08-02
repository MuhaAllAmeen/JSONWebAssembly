import QtQuick
import QtQuick.Window



Window {
    width: 500; height: 500
    visible: true
    Component.onCompleted: {
        var JsonString = '{"User1":1,"User2":3,"User3":2,"User4":5,"User5":7,"User6":3,"User7":9}';
        var JsonObject= JSON.parse(JsonString);

        //retrieve values from JSON again
        var aString = JsonObject.User1;
        var bString = JsonObject.User2;
        //        console.log(aString);
        //        console.log(bString);
        for (var i in JsonObject){
            if(JsonObject[i]>0){
                //                console.log(JsonObject[i])
                dataModel.append({"Users":i,"hours":JsonObject[i]})
            }
        }
    }


    Item {
        id: numbersArea
        width: 30; height: mainArea.height
        anchors {left:parent.left; right:mainArea.left; verticalCenter: parent.verticalCenter}

        Rectangle{
            width: parent.width; height:parent.height;

            Column{
                id: columnNumbers
                height: parent.height
                anchors.fill: parent
                spacing:20
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





    Item {

        id: mainArea
        width: parent.width-100; height: parent.height-100
        anchors.centerIn: parent
        Rectangle{
            id: mainAreaRect
            radius: 5
            width: parent.width; height: parent.height
            color:"black"
            ListModel{
                id:dataModel
            }

            ListView{
                clip: true
                anchors {left: parent.left; leftMargin: 10; right: parent.right; }
                width: parent.width; height: parent.height
                orientation: ListView.Horizontal
                spacing:parent.width/10
                model: dataModel
                Component.onCompleted: {console.log(dataModel.count)}

                delegate:
                    Rectangle{
                    id:barRect
                    anchors.bottom: parent.bottom;
                    width: 20; height: /*(hours*50)*/(parent.height/columnNumbers.spacing)* hours
                    color: "red"
                    ParallelAnimation{
                        running: true
                        PropertyAnimation {
                            id: animation;
                            target: barRect;
                            property: "height";
                            from: 0; to: barRect.height
                            duration: 1000
                        }
                        ColorAnimation {
                            target: barRect
                            property: "color"
                            duration: 2000
                            from: "black"; to: "red"
                            easing.type: Easing.InOutQuad
                        }

                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: console.log(columnNumbers.spacing,hours*columnNumbers.spacing, barRect.height)
                    }

                    Text{
                        text: hours
                        anchors {bottom:parent.top; horizontalCenter: parent.horizontalCenter}
                        color: "blue"
                    }

                    Text{
                        //                                                    anchors.centerIn: parent
                        anchors {bottom: parent.bottom; bottomMargin: 20; horizontalCenter: parent.horizontalCenter}
                        rotation: 90
                        text: Users
                        color: "white"
                    }
                }
            }
        }

    }
}

