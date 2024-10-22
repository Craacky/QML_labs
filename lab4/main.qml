import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    id: appWin
    visible: true
    width: 360
    height: 520

    Material.theme: Material.Dark
    Material.primary: "#006400"
    Material.accent: "#006400"

    property int previousElement
    property string currentIcon: "icons/add_call.svg"
    property bool addButtonStatus: false

    header: ToolBar {
        id: toolBar
        Material.background: "#006400"

        ToolButton {
            id: menuButton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            icon.source: currentIcon
            onClicked: {
                if (stackView.depth === 1) {
                    previousElement = 1
                    currentIcon = "icons/arrow_back.svg"
                    addButtonStatus = true
                    stackView.push(addPage)
                } else if (stackView.depth === 2 && previousElement === 1) {
                    currentIcon = "icons/add_call.svg"
                    addButtonStatus = false
                    stackView.pop()
                }
            }
        }

        Label {
            anchors.centerIn: parent
            text: "Contacts"
            font.bold: true
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: listPage
    }

    Component {
        id: listPage
        Item {
            width: appWin.width
            height: appWin.height
            Rectangle {
                anchors.fill: parent
                color: "#121212"

                ListView {
                    id: listView
                    anchors.fill: parent
                    model: myModel
                    delegate: Item {
                        id: item
                        property int itemIndex: index
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 70

                        RoundButton {
                            anchors.fill: parent
                            text: FirstName + " " + SurName + " " + MidleName + "\n" + Phone
                            background: Rectangle {
                                color: "#1E1E1E"
                                radius: 50
                            }
                            Material.foreground: "#006400"
                            onClicked: {
                                database.removeRecord(myModel.getId(itemIndex))
                                myModel.updateModel();
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: addPage
        Item {
            Rectangle {
                anchors.fill: parent
                color: "#121212"

                ColumnLayout {
                    id: columnLayout
                    y: toolBar.height
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 70
                    spacing: 20

                    TextField {
                        id: fnameField
                        Material.foreground: "white"
                        Material.background: "#1E1E1E"
                        placeholderText: "Enter FirstName"
                        Layout.fillWidth: true

                        onTextChanged: {
                            if(text.length > 20){
                                text = text.substring(0,20);
                            }
                            text = text.replace(/[^a-zA-Zа-яА-ЯёЁ]/g, "");
                        }
                    }
                    TextField {
                        id: snameField
                        Material.foreground: "white"
                        Material.background: "#1E1E1E"
                        placeholderText: "Enter Surname"
                        Layout.fillWidth: true
                        onTextChanged: {
                            if(text.length > 20){
                                text = text.substring(0,20);
                            }
                            text = text.replace(/[^a-zA-Zа-яА-ЯёЁ]/g, "");                        }
                    }
                    TextField {
                        id: mnameField
                        Material.foreground: "white"
                        Material.background: "#1E1E1E"
                        placeholderText: "Enter MiddleNname"
                        Layout.fillWidth: true
                        onTextChanged: {
                            if(text.length > 20){
                                text = text.substring(0,20);
                            }
                            text = text.replace(/[^a-zA-Zа-яА-ЯёЁ]/g, "");
                        }
                    }
                    TextField {
                        id: phoneField
                        Material.foreground: "white"
                        Material.background: "#1E1E1E"
                        placeholderText: "Enter PhoneNumber"
                        Layout.fillWidth: true
                        onTextChanged: {
                            if(text.length > 12){
                                text = text.substring(0,12);
                            }
                            text = text.replace(/[^0-9+]/g, "");
                        }
                    }

                    Button {
                        text: "Push"
                        Layout.fillWidth: true
                        Material.background: "#006400"
                        onClicked: {
                            database.insertIntoTable(fnameField.text, snameField.text, mnameField.text, phoneField.text);
                            myModel.updateModel();

                            fnameField.clear();
                            snameField.clear();
                            mnameField.clear();
                            phoneField.clear();
                        }
                    }
                }
            }
        }
    }
}
