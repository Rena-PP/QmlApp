import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.4

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Networking App")

    function fetchJokes(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            //XMLHttpRequest.HEADERS_RECEIVED
            //XMLHttpRequest.DONE
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED){
                console.log("HEADERS RECEIVED")
            }
            else if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status == 200) {
                    callback(xhr.responseText.toString())
                    console.log("Norm")
                } else {
                    callback(null)
                    console.log("Ne norma")
                }
            }
        }
        xhr.open("GET", url)
        xhr.send()
    }

    ColumnLayout{
        anchors.fill: parent
        spacing: 0

        ListModel {
            id: mListModelId
        }

        ListView {
            id: mListViewId
            model: mListModelId
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        SpinBox{
            id: spinBoxId
            Layout.fillWidth: true
            value:  10
        }

        Button{
            id: buttonId
            Layout.fillWidth: true
            text: "Fetch"
            onClicked: {
                console.log(spinBoxId.value)
            }
        }
    }
}
