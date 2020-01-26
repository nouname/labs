/**
 * Hand.qml - A part of the implementation of the RoShamBo
 * (Rock-Paper-Scissors game) with QtQuick technology
 *
 * This code is verified to be working with Qt 5.5
 *
 * Copyright (c) 2016, Alexander Borodin, aborod@petrsu.ru
 *
 * This code is licensed under MIT-style license
 */

import QtQuick 2.0

Item {

    property int type: 0

    height: width

    property var sources: [
        "images/rock.png",
        "images/paper.png",
        "images/scissors.png",
    ]

    signal clicked

    Rectangle {
        id: r
        anchors.fill: parent
        color: m.pressed ? "gray" : "white"
        opacity: 0.2
        radius: parent.width / 2
    }

    Image {
        id: text
        source: parent.sources[type]
        anchors.centerIn: parent
        width: parent.width / 1.7
        height: parent.heigth / 1.7
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: m
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}









