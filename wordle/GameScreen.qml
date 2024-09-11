import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14


Item {
    property int currentRow: 0 //satır kontrol
    property string currentGuess: ""
    property bool gameActive: true

    ListModel {
        id: lettersModel
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "#121213" // Ana arka plan rengi
    }

    //seperator
    Rectangle {
        id: separatorLine
        width: parent.width
        height: 2
        color: "#28282A"
        anchors.top: parent.top
        anchors.topMargin: 60
    }

    // Header Icons'u Yükleme
   Loader {
       source: "HeaderIcons.qml"
       anchors.left: separatorLine.left // HeaderIcons'u separatorLine'a göre hizalama
       anchors.right: separatorLine.right
       anchors.bottom: separatorLine.top // Seperator'un hemen üzerinde konumlandırma
   }

    // Oyun Tahtası
    GridLayout {
        id: gameBoard
        columns: 5
        rows: 6
        anchors.top: parent.top
        anchors.topMargin: 85
        anchors.horizontalCenter: parent.horizontalCenter
        columnSpacing: 10 // Sütun arası boşluk

        Repeater {
            model: 6 * 5 // 5 sütun x 6 satır
            Rectangle {
                width: 60
                height: 60
                color: "#121213"
                border.color: "#3A3A3C"
                border.width: 2

                Text {
                   text: model.index < lettersModel.count ? lettersModel.get(model.index).letter : ""
                   font.pixelSize: 20
                   color: "white"
                   anchors.centerIn: parent
               }
            }
        }
    }

    // Sanal Klavye komponenti
    Component {
        id: keybooardButton
        Rectangle {
            width: 52
            height: 72
            color: "#818384"
            radius: 6
            signal buttonClicked(string key) //buton tıklamalarını dışarıya iletmek için sinyal
            property string buttonText: ""

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true //imleç kontrolu içim

                onEntered: parent.color = "#b0b1b3" //hover durumu
                onExited: parent.color = "#818384"

                onPressed: parent.color = "#5D5F61" //butona basıldığında
                onReleased: parent.color = "#818384"

                onClicked: parent.buttonClicked(parent.buttonText)
            }

            Text {
                text: buttonText
                font.pixelSize: 26
                font.family: "Franklin Gothic Medium"
                font.bold: true
                anchors.centerIn: parent
                color: "white"
            }
        }
    }

    // Sanal Klavye
    ColumnLayout {
        anchors.top: parent.top
        anchors.topMargin: 500
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5 // satırlar arası

        RowLayout { // (Q, W, E, ...)
            spacing: 7 //rowlar arası
            Layout.alignment: Qt.AlignHCenter
            Repeater {
                model: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
                Loader {
                    sourceComponent: keybooardButton
                    onLoaded: {
                        item.buttonText = modelData;
                        item.buttonClicked.connect(function(key) {
                            if (currentGuess.length < 5) {
                                currentGuess += key; //geçerli kelimeyi güncelle
                                lettersModel.append({"letter": key}); // harfi modele ekle
                            }
                        });
                    }
                }
            }
        }

        RowLayout { // (A, S, D, ...)
            spacing: 7
            Layout.alignment: Qt.AlignHCenter
            Repeater {
                model: ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
                Loader {
                    sourceComponent: keybooardButton
                    onLoaded: {
                        item.buttonText = modelData;
                        item.buttonClicked.connect(function(key) {
                            if (currentGuess.length < 5) {
                                currentGuess += key;
                                lettersModel.append({"letter": key});
                            }
                        });
                    }
                }
            }
        }

        RowLayout { //(ENTER, Z, X, ...)
            spacing: 7
            Layout.alignment: Qt.AlignHCenter
            Loader {
                sourceComponent: keybooardButton
                onLoaded: {
                    item.width = 82;
                    item.buttonText = "ENTER";
                    item.buttonClicked.connect(function() {
                    // check the word
                    if (currentGuess.length === 5 && gameActive) {
                        // dataset check
                        if (fileManager.isWordInWordList(currentGuess)) {
                            console.log("The" + currentGuess + " word is in the dataset");

                            // renk sonucunu al
                            var comparisonResult = gameEngine.compareGuess(currentGuess);

                            // Tahtadaki hücrelerin renklerini güncelle
                            for (var i = 0; i < comparisonResult.length; i++) {
                                var color = comparisonResult[i];
                                gameBoard.children[currentRow * 5 + i].color = color;
                            }

                            if (gameEngine.checkGuess(currentGuess)) {
                                console.log("Daily word was found " + currentGuess);
                                gameActive = false;
                                // popups
                            } else {
                                console.log("but wrong guess");
                                // popups
                            }

                            currentRow++;
                            currentGuess = "";
                        } else {
                            console.log("The word is not in the dataset " + currentGuess + " Try again!");
                            // popups
                        }
                    }
                });
                    item.children[1].font.pixelSize = 16;
                }
            }
            Repeater {
                model: ["Z", "X", "C", "V", "B", "N", "M"]
                Loader {
                    sourceComponent: keybooardButton
                    onLoaded: {
                        item.buttonText = modelData;
                        item.buttonClicked.connect(function(key) {
                            if (currentGuess.length < 5) {
                                currentGuess += key;
                                lettersModel.append({"letter": key});
                            }
                        });
                    }
                }
            }
            Loader {
                sourceComponent: keybooardButton
                onLoaded: {
                    item.width = 81;
                    item.buttonText = "\u232B"; // Backspace
                    item.buttonClicked.connect(function() {
                        if (currentGuess.length > 0) {
                            currentGuess = currentGuess.slice(0, -1); // Son harfi sil
                            lettersModel.remove(lettersModel.count - 1);
                        }
                    });
                    item.children[1].font.pixelSize = 19;
                }
            }
        }
    }


    Popup {
        id: congratsPopup
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        modal: true
        focus: true
        width: 300
        height: 200
        background: Rectangle {
            color: "white"
            radius: 10
            border.color: "#4CAF50"
            border.width: 2
        }

        Column {
            anchors.centerIn: parent
            spacing: 20

            Text {
                text: "Congratulations!"
                font.pixelSize: 24
                color: "#4CAF50"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "You guessed the word correctly!"
                font.pixelSize: 16
                color: "#333333"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "OK"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: congratsPopup.close()
            }
        }
    }

    // GameEngine'in sinyallerine bağlanma
    Connections {
        target: gameEngine
        onGameWon: {
            console.log("Congratulations, you won!");
            congratsPopup.open();
            gameActive = false;
        }
        onGameOver: {
            console.log("Unfortunately, the game has ended.");
        }
    }

}
