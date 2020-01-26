/**
 * Tablo.qml - A part of the implementation of the RoShamBo
 * (Rock-Paper-Scissors game) with QtQuick technology
 *
 * This code is verified to be working with Qt 5.5
 *
 * Copyright (c) 2016, Alexander Borodin, aborod@petrsu.ru
 *
 * This code is licensed under MIT-style license
 */

import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property alias text: t.text
    property alias glowColor: g.color

    Rectangle {
        anchors.fill: parent
        color: "gray"
        radius: 10
        Text {
            id: t
            anchors.centerIn: parent
            color: "white"
            font.pointSize: 24
            font.bold: true
            text: "Text"
            opacity: 0.0
        }
        Glow {
            id: g
            anchors.fill: t
            radius: 15
            samples: 17
            color: "white"
            source: t
        }
    }
}
