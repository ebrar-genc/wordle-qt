import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

ApplicationWindow {
    visible: true
    width: 1300
    height: 900
    title: "WordleGamee"
    color: "#EDEDED"

    Loader {
        id: screenLoader
        anchors.fill: parent
        visible: false
        onLoaded: {
        visible = true
        }
    }

    /*Loader {
        id: screenLoader
        anchors.fill: parent
        visible: true
        source: "GameScreen.qml"
    }*/

    Item {
        id: mainContent
        anchors.fill: parent
        visible: true//***

        Column {
            anchors.centerIn: parent
            spacing: 15

            Image {
                source: "qrc:/Icons/Wordle_icon.png"
                width: 130
                height: 130
                anchors.horizontalCenter: parent.horizontalCenter //yatayda merkezle
            }

            Text {
                     text: "Wordle"
                     font.pixelSize: 60
                     font.family: "Serif"
                     font.weight: Font.Black
                     horizontalAlignment: Text.AlignHCenter
                     anchors.horizontalCenter: parent.horizontalCenter
                     color: "black"
            }

            Text {
                text: "Get 6 chances to guess\na 5-letter word."
                font.pixelSize: 45
                font.family: "Helvetica"
                font.weight: Font.Light
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                padding: 30
            }

            Rectangle {
                height: 30
                width: 1
                color: "transparent"
            }

            // Dil Seçimi
            RowLayout {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Select Language:"
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignVCenter
                }

                RadioButton {
                    id: enButton
                    text: "English"
                    onClicked: fileManager.setLanguage("en")
                    font.pixelSize: 12
                }

                RadioButton {
                    id: trButton
                    text: "Turkish"
                    onClicked: fileManager.setLanguage("tr")
                    font.pixelSize: 12
                }
            }

            // Oyun Modu Seçimi
            RowLayout {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Game Mode:"
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignVCenter
                }

                RadioButton {
                    id: limitedButton
                    text: "Limited"
                    onClicked: fileManager.setGameMode("limited")
                    font.pixelSize: 12
                }

                RadioButton {
                    id: unlimitedButton
                    text: "Unlimited"
                    onClicked: fileManager.setGameMode("unlimited")
                    font.pixelSize: 12
                }
            }

            // Play Butonu, Dil ve Mod seçilmeden aktif olmayacak
            Button {
                width: 150
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                    color: "black"
                    radius: 35
                }
                enabled: (enButton.checked || trButton.checked) && (limitedButton.checked || unlimitedButton.checked)
                onClicked: {
                    mainContent.visible = false
                    gameEngine.startGame()
                    screenLoader.source = "GameScreen.qml"
                }
                contentItem: Text {
                    text: "Play"
                    font.pixelSize: 15
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                height: 135
                width: 1
                color: "transparent"
            }

            Label {
                text: Qt.formatDate(new Date(), "MMMM d, yyyy") // güncel tarih
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: "Edited by egenc"
                font.pixelSize: 11
                anchors.horizontalCenter: parent.horizontalCenter
            }


        }
    }


}
