import QtQuick 2.14
import QtQuick.Controls 2.14

ApplicationWindow {
    visible: true
    width: 1300
    height: 900
    title: "WordleGamee"
    color: "#EDEDED"

    /*Loader {
        id: screenLoader
        anchors.fill: parent
        visible: false
        onLoaded: {
        visible = true
        }
    }*/


    Loader {
        id: screenLoader
        anchors.fill: parent
        visible: true
        source: "GameScreen.qml"
    }


    Item {
        id: mainContent
        anchors.fill: parent
        visible: false//***

        Column {
            anchors.centerIn: parent
            spacing: 20

            Image {
                source: "qrc:/Icons/Wordle_icon.png"
                width: 100
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter //yatayda merkezle
            }

            Text {
                     text: "Wordle"
                     font.pixelSize: 48
                     font.family: "Serif"
                     font.weight: Font.Black
                     horizontalAlignment: Text.AlignHCenter
                     anchors.horizontalCenter: parent.horizontalCenter
                     color: "black"
            }

            Text {
                text: "Get 6 chances to guess\na 5-letter word."
                font.pixelSize: 30
                font.family: "Helvetica"
                font.weight: Font.Light
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                width: 150
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                color: "black"
                radius: 35
                }
                onClicked: {
                    mainContent.visible = false // Ana içeriği gizle
                    gameEngine.startGame()
                    screenLoader.source = "GameScreen.qml" // Oyun ekranını yüklendi
                }
                contentItem: Text {
                    text: "Play"
                    font.pixelSize: 15
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter // Yatay hizalamayı ortalar
                    verticalAlignment: Text.AlignVCenter // Dikey hizalamayı ortalar
                }
            }


            Label {
                text: Qt.formatDate(new Date(), "MMMM d, yyyy") // güncel tarih
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: "Edited by egenc"
                anchors.horizontalCenter: parent.horizontalCenter
            }


        }
    }


}
