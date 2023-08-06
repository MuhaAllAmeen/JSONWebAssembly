import QtQuick
import QtQuick.Window



Window {
    width: 1000; height: 1000
    visible: true
    Component.onCompleted: {
        var JsonString = '{"User1":{"sunday":3,"monday":2,"tuesday":5,"wednesday":6,"thursday":2,"friday":5,"saturday":9},"User2":{"sunday":5,"monday":1,"tuesday":4,"wednesday":8,"thursday":3,"friday":2,"saturday":6},"User3":{"sunday":2,"monday":5,"tuesday":2,"wednesday":1,"thursday":6,"friday":7,"saturday":3}}';
        var JsonObject= JSON.parse(JsonString);
        var hours = 0
        var i = 0
        //retrieve values from JSON again
        for (var userNames in JsonObject){
            dataModel.append({"Users":userNames,"dayModel":[]})


            for (var days in JsonObject[userNames]){
                var day = days
                var value = JsonObject[userNames][day]
                var newAdd = {}
                newAdd[day]=value
                dataModel.get(i).dayModel.append({"day":value,"dayColor":"red","number":0})

                hours = hours+JsonObject[userNames][days]
            }
            dataModel.set(i,{"hours":hours})
            i=i+1
            console.log("hours",hours)
            hours= 0
            console.log("hours here",dataModel.get(0).hours)
        }
        var dayColors = ["red","blue","green","yellow","grey","violet","lightblue"]
        for (var j=0; j<dayColors.length;j++){
            for (var k=0; k<dataModel.count; k++){
                dataModel.get(k).dayModel.set(j,{"dayColor":dayColors[j],"number":j})
            }
        }

        console.log(dataModel.get(0).dayModel.get(0).dayColor)
    }


    NumbersArea{id: numbersArea}
//    Item{
//            id: numbersArea
//            width: 30; height: mainArea.height
//            anchors {left:parent.left; right:mainArea.left; verticalCenter: parent.verticalCenter}

//            Rectangle{
//                width: parent.width; height:parent.height;

//                Column{
//                    id: columnNumbers
//                    height: parent.height
//                    anchors.fill: parent
//                    spacing:40
//                    rotation: 180
//                    clip: true
//                    Repeater{
//                        model: 40
//                        delegate: Text{
//                            rotation: 180
//                            text: index
//                        }
//                    }
//                }
//            }
//        }


    Component{
        id: barChartDelegate
        BarChartDelegate{}

    }

    ToggleBtn{}

    Component{
        id:lineChartDelegate
        LineChartDelegate{}

    }

    ListModel{
        id:sampleModel

    }






    Item {

        id: mainArea
        width: parent.width-100; height: parent.height-100
        anchors.centerIn: parent

        ColorLabels{}

        Rectangle{
            id: mainAreaRect
            radius: 5
            width: parent.width; height: parent.height
            color:"black"
            Row{
                anchors{top: parent.top; topMargin: 10; left: parent.left; leftMargin: 10}
                width:100; height:100; spacing: 5;
                Repeater{
                    width: parent.width; height: parent.height;
                    model: dataModel
                    delegate:
                        Rectangle{
                        id: userSelectRect
                        width: 60; height: 30; color: userNameMouse.pressed ? "red" : "white" ; radius:5
                        Text{
                            id: userTextfromBtn
                            anchors.centerIn: parent
                            text: Users
                        }
                        MouseArea{
                            id: userNameMouse
                            anchors.fill: parent
                            onClicked: {
                                if(userTextfromBtn.text==dataModel.get(index).Users){
                                    console.log("got")
                                    listView.currentIndex=index
                                }
                            }
                        }
                    }
                }
            }

            ListModel{
                id:dataModel
            }

            ListView{
                id:listView
                clip: true
                anchors {bottom: parent.bottom; horizontalCenter: parent.horizontalCenter}
                width: 600; height: parent.height - 100
                orientation: ListView.Horizontal
                spacing:parent.width/count
                model: dataModel
                //                currentIndex: 1
                //                highlightFollowsCurrentItem: true
                focus: true
                Component.onCompleted: {
                    console.log("currentItem",listView.currentItem)
                }

                delegate: barChartDelegate


            }

        }

    }
}

