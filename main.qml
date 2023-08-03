import QtQuick
import QtQuick.Window



Window {
    width: 500; height: 500
    visible: true
    Component.onCompleted: {
        var JsonString = '{"User1":{"sunday":3,"monday":2,"tuesday":5,"wednesday":7,"thursday":2,"friday":5,"saturday":9},"User2":{"sunday":5,"monday":1,"tuesday":4,"wednesday":8,"thursday":3,"friday":2,"saturday":6}}';
                var JsonObject= JSON.parse(JsonString);
                var hours = 0
                var i = 0
                //retrieve values from JSON again
                var aString = JsonObject.User1;
                var bString = JsonObject.User2;
                for (var userNames in JsonObject){
                    dataModel.append({"Users":userNames,"dayModel":[]})

//                    sampleModel.append({"Users":userNames,"sunday":0,"monday":0,"tuesday":0,"wednesday":0,"thursday":0,"friday":0,"saturday":0,"hours":0})

                    for (var days in JsonObject[userNames]){
                        var day = days
                        var value = JsonObject[userNames][day]
                        var newAdd = {}
                        newAdd[day]=value
//                        sampleModel.get(i).dayModel.append(newAdd)
                        dataModel.get(i).dayModel.append({"day":value,"dayColor":"red","number":0})

//                        sampleModel.set(i,newAdd)
                            hours = hours+JsonObject[userNames][days]
                    }
                    dataModel.set(i,{"hours":hours})
                    i=i+1
                    console.log("hours",hours)
                    hours= 0
                }
                var dayColors = ["red","blue","green","yellow","grey","violet","lightblue"]
                for (var j=0; j<dayColors.length;j++){
                    for (var k=0; k<dataModel.count; k++){
                        dataModel.get(k).dayModel.set(j,{"dayColor":dayColors[j],"number":j})
                    }
                }

                console.log(dataModel.get(0).dayModel.get(0).dayColor)
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


    Component{
        id: barChartDelegate2
        Row{
            spacing: 5
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
                    width: 20; height: (parent.height/columnNumbers.spacing)* day; color:dayColor
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

    }

    Component{
        id:lineChartDelegate
        Column{
            spacing: 0
            height: parent.height
            rotation: 180
            Repeater{
                model: dayModel
                height: parent.height
//                anchors.bottom: parent.bottom

                delegate: Rectangle{
//                    anchors.bottom: parent.bottom
                    function xValue(){
                        console.log(index)
                        return dayModel.get(index).number*2
                    }

                    x: -(xValue()*40)
                    antialiasing: true
//                    y:
                    id:dayBarRect
                    width: 2; height: (parent.height/columnNumbers.spacing)* day; color:dayColor
                    rotation:(day*7)
                    transformOrigin: Item.Top
//                    transform: Rotation{
//                        origin{x: 0; y:dayBarRect.height}
//                        angle: 45

//                    }
                    Text{
                        anchors.centerIn: parent
                        text: day
                    }
                }
            }
        }

    }

    ListModel{
        id:sampleModel

    }




    Item {

        id: mainArea
        width: parent.width-100; height: parent.height-100
        anchors.centerIn: parent

        Row{
            spacing: 7
            width: parent.width; height:parent.height;
            anchors{top: mainAreaRect.bottom; topMargin:5; left:mainAreaRect.left; right:mainAreaRect.right}
            ObjectModel { /*["red","blue","green","yellow","grey","violet","lightblue"]*/
                    id: itemModel
                    Rectangle { height: 30; width: 50; color: "red"; radius:5
                        Text{anchors.centerIn: parent; text:"Sunday"; font.pixelSize:10}
                    }
                    Rectangle { height: 30; width: 50; color: "blue"; radius:5
                    Text{anchors.centerIn: parent; text:"Monday"; font.pixelSize:10}}
                    Rectangle { height: 30; width: 50; color: "green"; radius:5
                    Text{anchors.centerIn: parent; text:"Tuesday"; font.pixelSize:10}}
                    Rectangle { height: 30; width: 60; color: "yellow"; radius:5
                    Text{anchors.centerIn: parent; text:"Wednesday"; font.pixelSize:10}}
                    Rectangle { height: 30; width: 50; color: "grey"; radius:5
                    Text{anchors.centerIn: parent; text:"Thursday"; font.pixelSize:10}}
                    Rectangle { height: 30; width: 50; color: "violet"; radius:5
                    Text{anchors.centerIn: parent; text:"Friday"; font.pixelSize:10}}
                    Rectangle { height: 30; width: 50; color: "lightblue"; radius:5
                    Text{anchors.centerIn: parent; text:"Saturday"; font.pixelSize:10}}
                }
            Repeater{
                model: itemModel

            }


        }

        Rectangle{
            id: mainAreaRect
            radius: 5
            width: parent.width; height: parent.height
            color:"black"
            ListModel{
                id:dataModel
            }

            ListView{
                id:listView
                clip: true
                anchors {left: parent.left; leftMargin: 10; right: parent.right; }
                width: parent.width; height: parent.height
                orientation: ListView.Horizontal
                spacing:parent.width/10
                model: dataModel /*sampleModel*/
                Component.onCompleted: {
                    console.log(dataModel.count)
                }

                delegate: barChartDelegate2


            }
            Rectangle{
                id: toggleBtn
                width: 40; height: 20
                color:"darkred"
                radius:10
                anchors {top: parent.top; topMargin: 20; horizontalCenter: parent.horizontalCenter}
                Rectangle{
                    width: 20; height: 20; color: "red"; radius:20
                    NumberAnimation on x {
                        function whichPage(){
                            if (listView.delegate==barChartDelegate2){
                                return toggleBtn.width/2
                            }
                            else{
                                return 0
                            }
                        }
                        id: toggleAnimation
                        to: whichPage()
                        easing.type: Easing.InBack
                        duration: 200; running: false
                    }

                }

                MouseArea{
                    id: myMouse
                    anchors.fill: parent
                    onClicked: {
                        toggleAnimation.running = true
                        listView.delegate==barChartDelegate2 ? listView.delegate=lineChartDelegate : listView.delegate = barChartDelegate2
                    }
                }
            }
        }

    }
}

