import QtQuick

Rectangle{
    id: toggleBtn
    width: 40; height:20; color:"darkred"
    radius:10
    anchors {top: parent.top; topMargin: 20; horizontalCenter: parent.horizontalCenter}
    Rectangle{
        width: 20; height: 20; color: "red"; radius:20
        NumberAnimation on x {
            function whichPage(){
                if (listView.delegate===barChartDelegate){
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
        anchors.fill: parent
        onClicked: {
            toggleAnimation.running = true
            listView.currentIndex = 0
            listView.delegate===barChartDelegate ? listView.delegate=lineChartDelegate : listView.delegate = barChartDelegate

        }
    }
}
