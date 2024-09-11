import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14


Item {

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
                    text: "" //harfler burada görünecek
                    font.pixelSize: 20
                    color: "white"
                    anchors.centerIn: parent
                }
            }
        }
    }

    // Sanal Klavye Ortak Buton Bileşeni komponent tanımı
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
                            // Tuş işlemleri buradaa
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
                            //tuş işlemleri
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
                    item.buttonClicked.connect(function(key) {
                        // Enter işlemi
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
                            // Tuş işlemleri burada
                        });
                    }
                }
            }
            Loader {
                sourceComponent: keybooardButton
                onLoaded: {
                    item.width = 81;
                    item.buttonText = "\u232B"; // Backspace
                    item.buttonClicked.connect(function(key) {
                        // Geri silme işlemi
                    });
                    item.children[1].font.pixelSize = 19;
                }
            }
        }
    }



}
