import QtQuick

Row{
    visible: listView.delegate==barChartDelegate
    spacing: (7/70)*parent.width
    width: parent.width; height:parent.height;
    anchors{top: mainAreaRect.bottom; topMargin:5; horizontalCenter: parent.horizontalCenter}
    ObjectModel { /*["red","blue","green","yellow","grey","violet","lightblue"]*/
            id: itemModel
            Rectangle { height: 30; width: 70; color: "red"; radius:5;
                Text{anchors.centerIn: parent; text:"Sunday"; font.pixelSize:10}
            }
            Rectangle { height: 30; width: 70; color: "blue"; radius:5
            Text{anchors.centerIn: parent; text:"Monday"; font.pixelSize:10}}
            Rectangle { height: 30; width: 70; color: "green"; radius:5
            Text{anchors.centerIn: parent; text:"Tuesday"; font.pixelSize:10}}
            Rectangle { height: 30; width: 70; color: "yellow"; radius:5
            Text{anchors.centerIn: parent; text:"Wednesday"; font.pixelSize:10}}
            Rectangle { height: 30; width: 70; color: "grey"; radius:5
            Text{anchors.centerIn: parent; text:"Thursday"; font.pixelSize:10}}
            Rectangle { height: 30; width: 70; color: "violet"; radius:5
            Text{anchors.centerIn: parent; text:"Friday"; font.pixelSize:10}}
            Rectangle { height: 30; width: 70; color: "lightblue"; radius:5
            Text{anchors.centerIn: parent; text:"Saturday"; font.pixelSize:10}}
        }
    Repeater{
        model: itemModel

    }


}
