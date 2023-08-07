import QtQuick

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
