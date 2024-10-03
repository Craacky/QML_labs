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

    property int previousElement
    property string currentIcon: "icons/add_call.svg"
    property bool addButtonStatus: false

    header: ToolBar {
        id: toolBar

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
        ToolButton {
            id: addButton
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "icons/add.svg"
            visible: addButtonStatus
            onClicked: {
                var fname = addPageComponent.fnameField.text;
                var sname = addPageComponent.snameField.text;
                var mname = addPageComponent.mnameField.text;
                var phone = addPageComponent.phoneField.text;

                database.insertIntoTable(fname, sname, mname, phone);
                myModel.updateModel();

                addButtonStatus = false;
                addPageComponent.fnameField.clear();
                addPageComponent.snameField.clear();
                addPageComponent.mnameField.clear();
                addPageComponent.phoneField.clear();

                stackView.pop();


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

        Item{
            width: appWin.width
            height: appWin.height
            Rectangle {
                anchors.fill: parent
                ListView {
                    id: listView
                    anchors.fill: parent
                    model: myModel
                    delegate: Item {
                        id: item
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 52
                        Button {
                            anchors.fill: parent
                            text: FirstName + SurName + MidleName + Phone
                            onPressAndHold: {
                                database.removeRecord(myModel.getId(listView.currentItem) + 1)
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
        Item{
            Rectangle {
                anchors.fill: parent
                ColumnLayout {
                    id: columnLayout
                    anchors.centerIn: parent
                    spacing: 10
                    Text { text: qsTr("FirstName:"); font.pixelSize: 16 }
                    TextField { id: fnameField }
                    Text { text: qsTr("Surname:"); font.pixelSize: 16 }
                    TextField { id: snameField }
                    Text { text: qsTr("MidleName:"); font.pixelSize: 16 }
                    TextField { id: mnameField }
                    Text { text: qsTr("phone:"); font.pixelSize: 16 }
                    TextField { id: phoneField }
                }

            }
        }
    }
}
