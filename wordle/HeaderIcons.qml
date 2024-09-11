import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Item {
    Rectangle {
        width: parent.width
        height: parent.height
        color: "#121213" // Ana arka plan rengi
    }

    // İkonlar için bilgiler
    ListModel {
       id: iconModel
       ListElement { iconSource: "qrc:/Icons/clue.png"; popupText: "Clue" }
       ListElement { iconSource: "qrc:/Icons/analytics.png"; popupText: "Statics" }
       ListElement { iconSource: "qrc:/Icons/question-mark.png"; popupText: "Help" }
       ListElement { iconSource: "qrc:/Icons/settings.png"; popupText: "Settings" }
    }

    //ikonlar
    RowLayout {
      spacing: 2 // Öğeler arası boşluk
      anchors.right: parent.right //sağda hizalandı**
      anchors.bottom: parent.bottom // seperator üstünde konumlandı

      //ikon Butonları
      Repeater {
          model: iconModel
          delegate: Rectangle {
              width: 70
              height: 60
              color: "transparent" // Ana arka plan rengi

              // Her bir ikona ait popup
              Rectangle {
                  id: popup
                  visible: false
                  width: 70
                  height: 20
                  color: "transparent"
                  anchors.top: parent.bottom // seperator altına konumlandı
                  Text {
                      text: model.popupText
                      font.pixelSize: 12
                      color: "white"
                      anchors.centerIn: parent // ikon referans olarak konumlandı
                  }
              }

              MouseArea {
                  id: iconArea
                  anchors.fill: parent
                  hoverEnabled: true

                  onEntered: {
                      parent.color = "#5D5F61"// Hover durumu
                      popup.visible = true
                  }
                  onExited: {
                      parent.color = "transparent"
                      popup.visible = false
                  }

                  onClicked: {
                      if (model.popupText === "Clue") {
                          cluePopup.open()
                      }
                      else if (model.popupText === "Statics") {
                          //staticsPopup.open()
                      }
                      else if (model.popupText === "Help") {
                          helpPopup.open()
                      }
                      else if (model.popupText === "Settings") {
                        settingsPopup.open()
                      }

                    }

                  Image {
                      source: model.iconSource
                      anchors.centerIn: parent
                      fillMode: Image.PreserveAspectFit
                      width: 30
                      height: 30
                    }
                }
            }
        }
    }

    // Settings Popup
    Popup {
        id: settingsPopup
        width: 150
        height: 75
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        // seperatorun en sagına popup hizalandı
        x: parent.width - width - 20
        y: 0
        background: Rectangle {
            color: "#5D5F61" // **Popup arka plan rengi**
            Column {
                padding: 5
                anchors.fill: parent
                Button {
                    text: "Settings"
                    onClicked: {
                        console.log("Settings button is clicked");
                    }
                }
            }
        }

    }

    //How to Play Popup
   Popup {
       id: helpPopup
       width: 150
       height: 75
       modal: true
       closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

       // seperatorun en sagına popup hizalandı
       x: parent.width - width - 20
       y: 0
       background: Rectangle {
           color: "#5D5F61"
           // Popup İçeriği
           Column {
               padding: 5
               anchors.fill: parent
               Button {
                   text: "How to Play"
                   onClicked: {
                       console.log("How To Play button is clicked");
                       howToPlayPopupLoader.source = "HowToPlay.qml"
                   }
               }
           }
       }
   }

    // How to Play popup'ını yüklemek için Loader
    Loader {
        id: howToPlayPopupLoader
        anchors.fill: parent
        visible: false // Başlangıçta görünmez
        onLoaded: {
        visible = true // Yüklendikten sonra görünür yap
        }
    }


}
