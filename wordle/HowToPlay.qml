import QtQuick 2.14
import QtQuick.Controls 2.14

Popup {
    id: howToPlayPopup
    visible: true
    width: 520
    height: 650
    modal: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    anchors.centerIn: parent // Popup'ı parent'in ortasına hizalar

    onOpened: {
        console.log("How to Play Popup is opened");
    }

    onClosed: {
        console.log("How to Play Popup is closed");
    }

    Rectangle {
        anchors.fill: parent
        color: "#15150d"
        radius: 1

        Label {
            text: "How To Play"
            color: "white"
            font.pixelSize: 30
            font.family: "Palo Slab Condensed Xbold"
            font.bold: true
            anchors.leftMargin: 30
            anchors.topMargin: 60
            anchors.left: parent.left
            anchors.top: parent.top
        }


        Column {
            spacing: 5
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 30
            anchors.topMargin: 90

            Label {
                text: "Guess the Wordle in 6 tries."
                color: "white"
                font.pixelSize: 25
                font.family: "KarnakPro-Medium"
            }

            Label {
                text: "• Each guess must be a valid 5-letter word."
                color: "white"
                font.pixelSize: 20
                font.bold: true
                font.family: "Arial"
            }

            Label {
                text: "• The color of the tiles will change to show how close your guess was to the word."
                color: "white"
                font.pixelSize: 18
                font.bold: true
                font.family: "Arial"
                wrapMode: Text.WordWrap
            }
        }

        Column {
            spacing: 20
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 30
            anchors.topMargin: 290

            Label {
                text: "Examples"
                color: "white"
                font.pixelSize: 14
                font.family: "Impact"
            }

            Row {
                spacing: 10
                Repeater {
                    model: ["W", "O", "R", "D", "Y"]
                    delegate: Rectangle {
                        width: 35
                        height: 35
                        color: index === 0 ? "#538D4E" : "#121213"
                        border.color: "#606162"
                        Text {
                            text: modelData
                            color: "white"
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.family: "Clear Sans"
                            font.bold: true
                        }
                    }
                }
            }

            Label {
                text: "W is in the word and in the correct spot."
                color: "white"
                font.pixelSize: 12
                font.family: "Franklin Gothic Book"
            }

            Row {
                spacing: 10
                Repeater {
                    model: ["L", "I", "G", "H", "T"]
                    delegate: Rectangle {
                        width: 35
                        height: 35
                        color: index === 1 ? "#B59F3B" : "#121213"
                        border.color: "#606162"
                        Text {
                            text: modelData
                            color: "white"
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.family: "Clear Sans"
                            font.bold: true
                        }
                    }
                }
            }

            Label {
                text: "I is in the word but in the wrong spot."
                color: "white"
                font.pixelSize: 12
                font.family: "Franklin Gothic Book"
            }

            Row {
                spacing: 10
                Repeater {
                    model: ["R", "O", "G", "U", "E"]
                    delegate: Rectangle {
                        width: 35
                        height: 35
                        color: index === 3 ? "#3A3A3C" : "#121213"
                        border.color: "#606162"
                        Text {
                            text: modelData
                            color: "white"
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.family: "Clear Sans"
                            font.bold: true
                        }
                    }
                }
            }

            Label {
                text: "U is not in the word in any spot."
                color: "white"
                font.pixelSize: 12
                font.family: "Franklin Gothic Book"
            }
        }
    }
}
