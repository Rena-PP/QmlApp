import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.4

Window {
    width: 720
    height: 480
    visible: true
    title: qsTr("Hello World")

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

    ColumnLayout {
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
        SpinBox {
            id: spinBoxId
            Layout.fillWidth: true
            value: 10

        }
        Button {
            id: buttonId
            Layout.fillWidth: true
            text: "Fetch"
            onClicked: {
                console.log("https://v2.jokeapi.dev/joke/Any?type=single&amount=" + spinBoxId.value)
                fetchJokes("https://v2.jokeapi.dev/joke/Any?type=single&amount=" + spinBoxId.value, function(response) {
                    if (response) {
                        var object = JSON.parse(response)
                        //console.log(object)
                        object.jokes.forEach(function(element) {
                            mListModelId.append({"joke" : element.joke,
                                                 "id" : element.id,
                                                 "category" : element.category})})
                    } else {
                        console.log("Something went wrong")
                    }
                }
                )
            }
        }

        Component {
            id: delegateId
            Row {
                width: parent.width
                spacing:0

                Rectangle {
                    id: rectangleIdId
                    width: parent.width * 0.1
                    height: rectangleIdJoke.height
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
                    width: parent.width * 0.75
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
                    width: parent.width * 0.15
                    height: rectangleIdJoke.height
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
