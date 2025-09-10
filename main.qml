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
            delegate: delegateId
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

            }
        }


        Component {
            id:
            Row {
                width: parent.width
                spacing: 5

                Rectangle {
                    id: rectangleIdId
                    width: parent.width * 0.1
                    height: Math.max(textIdId.implicitHeight + 30, 50)
                    color: "beige"
                    border.color: "yellowgreen"
                    radius: 5

                    Text {
                        id: textIdId
                        text: id
                        width: parent.width - 10
                        height: parent.height
                        anchors.centerIn: parent
                        font.pointSize: 11
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                    }
                }

                Rectangle {
                    id: rectangleIdJoke
                    width: parent.width * 0.7
                    height: Math.max(textIdJoke.implicitHeight + 30, 50)
                    color: "beige"
                    border.color: "yellowgreen"
                    radius: 5
                    Text {
                        id: textIdJoke
                        text: joke
                        width: parent.width - 10
                        height: parent.height
                        anchors.centerIn: parent
                        font.pointSize: 11
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        elide: Text.ElideRight
                    }
                }

                Rectangle {
                    id: rectangleIdCategory
                    width: parent.width * 0.2
                    height: Math.max(textIdCategory.implicitHeight + 30, 50)
                    color: "beige"
                    border.color: "yellowgreen"
                    radius: 5

                    Text {
                        id: textIdCategory
                        text: category
                        width: parent.width - 10
                        height: parent.height
                        anchors.centerIn: parent
                        font.pointSize: 11
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                    }
                }
            }
        }
    }
}
