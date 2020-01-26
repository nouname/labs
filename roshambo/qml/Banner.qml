/**
 * Banner.qml - A part of the implementation of the RoShamBo
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
    id: banner
    property int human: 0
    property int computer: 0

    signal clicked

    Rectangle {
        id: r
        anchors.fill: parent
        color: "white"
        opacity: 0.2
        radius: parent.width / 20
    }

    RowLayout {
        spacing: 20
        anchors.centerIn: parent
        width: parent.width
        signal selected(int type)

        Hand {
            type: banner.human
            width: (parent.width - 3 * parent.spacing) / 2
            Layout.alignment: Qt.AlignHCenter
        }
        Hand {
            type: banner.computer
            width: (parent.width - 3 * parent.spacing) / 2
            Layout.alignment: Qt.AlignHCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: r.color = "gray"
        onReleased: r.color = "white"
        onClicked: parent.clicked()
    }
}

