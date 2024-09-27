import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtLocation
import QtPositioning

ApplicationWindow {
    visible: true
    width: 360
    height: 520
    title: ""
    Material.accent: Material.LightGreen

    header: ToolBar{
        Material.background: Material.Green

        ToolButton{
            id: menuButton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "icons/description_24dp_000000_FILL0_wght400_GRAD0_opsz24.svg"
            onClicked: {
                if(drawer.opened){
                    drawer.close()
                }else{
                    drawer.open()
                }
            }
        }

        Label {
            anchors.centerIn: parent
            text: "Maps"
            font.bold: true
        }
    }


    StackView {
        id: stackView
        anchors.fill: parent
        anchors.topMargin: toolBar.height

        initialItem: page1
    }

    Component {
        id: page1
        Item {
            width: parent.width
            height: parent.height

            Rectangle {
                color: "white"
                anchors.fill: parent
                Text {
                    text: "This is Page 1"
                    anchors.centerIn: parent
                    font.pointSize: 24
                }
            }
        }
    }

    Component {
        id: page2
        Item {
            width: parent.width
            height: parent.height

            Rectangle {
                color: "lightgreen"
                anchors.fill: parent
                Text {
                    text: "This is Page 2"
                    anchors.centerIn: parent
                    font.pointSize: 24
                }
            }
        }
    }
}
