/**
 * Input.qml - A part of the implementation of the RoShamBo
 * (Rock-Paper-Scissors game) with QtQuick technology
 *
 * This code is verified to be working with Qt 5.5
 *
 * Copyright (c) 2016, Alexander Borodin, aborod@petrsu.ru
 *
 * This code is licensed under MIT-style license
 */

import QtQuick 2.5
import QtQuick.Layouts 1.1

Item {
    id: options

    width: 300
    height: 50

    property alias text: caption.text
    property int number: 3

    Rectangle {
        id: r
        anchors.fill: parent
        color: "white"
        opacity: 0.2
        radius: 10
    }

    RowLayout {
        anchors.centerIn: parent

        Text {
            id: caption
            text: "Button"
            font.pointSize: 20
            color: "white"
        }

        TextInput {
            id: textinput
            text: options.number
            font.pointSize: 20
            color: "white"

            onTextChanged: {
                var num = parseInt(text)
                if (isNaN(num) || num < 1) {
                    r.color = "red"
                } else {
                    r.color = "white"
                }
            }

            onVisibleChanged: {
                var num = parseInt(text)
                if (!isNaN(num) && num > 0) {
                    options.number = num
                } else {
                    text = options.number
                }
            }
        }
    }


}









