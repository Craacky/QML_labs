import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Dialogs

ApplicationWindow {
    id: mainApp
    width: 360
    height: 520
    visible: true
    title: qsTr("Check full name")

    Material.accent: Material.Green

    property string fullName: "Kolya Yakutin"

    header: ToolBar{
        Material.background: Material.Green

        ToolButton{
            id: menuButton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "icons/menu_24dp_E8EAED.svg"
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
            text: "Check full name"
            font.bold: true
        }
    }




    Drawer{
        id: drawer
        y: header.height
        width: mainApp.width / 2
        height: mainApp.height
        edge: "LeftEdge"
        closePolicy: drawer.NoAutoClose
        Column{
            anchors.fill: parent

            ItemDelegate {
                width: parent.width
                onClicked: {
                    drawer.close()
                    aboutDialog.open()
                }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10
                    padding: 5

                    Image {
                        source: "icons/info_24dp_E8EAED.svg"
                        width: 24
                        height: 24
                    }

                    Text {
                        text: qsTr("About program")
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            ItemDelegate {
                width: parent.width
                onClicked: {
                    drawer.close()
                    exitDialog.open()
                }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10
                    padding: 5

                    Image {
                        source: "icons/logout_24dp_E8EAED.svg"
                        width: 24
                        height: 24
                    }

                    Text {
                        text: qsTr("Exit")
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

        }

    }

    Column {
        width: parent.width - 60
        anchors.centerIn: parent
        spacing: 10
        TextField {
           id: nameInput
           width: parent.width
           horizontalAlignment: "AlignHCenter"
           placeholderText: qsTr("Enter full name")
           font.pixelSize: 16
           onTextChanged: {
                var validText = text.replace(/[^a-zA-Z\s]/g, "");
                if (text !== validText) {
                     text = validText;
                }
               }
        }

        Row {
           spacing: 10
           anchors.horizontalCenter: parent.horizontalCenter

            Button {
               text: qsTr("Clear")
               onClicked: nameInput.text = ""
            }

            Button {
               text: qsTr("Check")
               onClicked: {
                   if (nameInput.text === fullName) {
                       resultDialog.title = qsTr("Match")
                       resultLabel.text = qsTr("Full name matches!")
                   } else {
                       resultDialog.title = qsTr("No Match")
                       resultLabel.text = qsTr("Full name does not match.")
                   }
                   resultDialog.open()
                }
            }
        }
    }

    Dialog {
        id: resultDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: qsTr("About Program")

        Label {
            id: resultLabel
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCentre
            text: qsTr("")
            horizontalAlignment: Text.AlignHCenter
        }
        standardButtons: Dialog.Ok
    }

    Dialog {
        id: aboutDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: qsTr("About Program")

        Label {
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCentre
            text: qsTr("Program for check full name")
            horizontalAlignment: Text.AlignHCenter
        }
        standardButtons: Dialog.Ok
    }

    Dialog {
        id: exitDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: qsTr("Exit")

        Label {
            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCentre
            text: qsTr("Are you sure you want to leave ?")
            horizontalAlignment: Text.AlignHCenter
        }
        standardButtons: Dialog.Yes | Dialog.Cancel
        onAccepted: Qt.quit()
        onRejected: exitDialog.close()
    }

}

