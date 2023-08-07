import QtQuick

Rectangle{
            height: 600; width:600
            color: "transparent"
            anchors{bottom: parent.bottom;}

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
                    var startY = parent.height;

                    ctx.strokeStyle = dayModel.get(index).dayColor;
                    ctx.lineWidth = 2;
                    ctx.lineTo(startX,startY);
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
                        ctx.fillText(dayList[i],x-(spacing/2)/1.5,parent.height/*y-10*/)

                        startX = x;
                        startY = y;
                    }

                    // Mark the graph as drawn
                    graphDrawn = true;
                }
            }
        }
