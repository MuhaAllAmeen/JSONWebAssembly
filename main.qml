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



    Component{
        id: barChartDelegate2
        Row{
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
                    width: 30; height: ((day/columnNumbers.spacing)* parent.height)*3.4 ; color:dayColor
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
    ToggleBtn{}

    Component{
        id:lineChartDelegate
        Rectangle {
            height: 600; width:600
            anchors{bottom: parent.bottom;}
            color: "transparent"

            Text{
                anchors {top:parent.top; topMargin: 20; horizontalCenter: parent.horizontalCenter }
                text: Users
                color: "white"
            }
            Canvas {
                id: graphCanvas
                height: parent.height; width:parent.width

                property bool graphDrawn: false

                onPaint: {drawGraph()}


                function drawGraph() {
                    var ctx = getContext("2d");
                    var maxValue = 0;


                    for (var l=0; l<dayModel.count;l++){
                        maxValue = Math.max(maxValue, dataModel.get(index).dayModel.get(l).day);
                    }

                    console.log("max",maxValue)
                    // Calculate the width and height of the canvas
                    var canvasWidth = parent.width;
                    var canvasHeight = parent.height;

                    // Calculate the space between each point on the graph
                    var spacing = canvasWidth / (dayModel.count);

                    // Set up the starting point for drawing the graph
                    var startX = 0;
                    var startY = 0

                    ctx.strokeStyle = dayModel.get(index).dayColor;
                    ctx.lineWidth = 2;
                    ctx.lineTo(0,parent.height);
                    ctx.stroke();
                    var dayList=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
                    // Draw the graph and labels
                    for (var i = 0; i < dayModel.count; i++) {
                        var value = dayModel.get(i).day

                        var x = startX + spacing-1;
                        var y = (canvasHeight - (value / maxValue) * canvasHeight)+20;

                        // Draw line segment
                        ctx.lineTo(x, y);
                        ctx.stroke();
                        ctx.lineJoin="round"
                        // Draw label with value at each data point
                        ctx.font = "10px Arial";
                        ctx.fillStyle = "white";
                        ctx.textAlign = "center";
                        ctx.fillText(value.toString(), x, y - 10);
                        //                        ctx.fillRect(x-5, y-5, 10, 10);
                        //                        ctx.roundedRect(x-2,y-3,5,5,2,2)
                        ctx.fillText(dayList[i],x-spacing/1.5,y-10)

                        startX = x;
                        startY = y;
                    }

                    // Mark the graph as drawn
                    graphDrawn = true;
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

                delegate: barChartDelegate2


            }

        }

    }
}

