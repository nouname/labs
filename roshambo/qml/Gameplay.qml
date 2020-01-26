/**
 * Gameplay.qml - A part of the implementation of the RoShamBo
 * (Rock-Paper-Scissors game) with QtQuick technology
 *
 * This code is verified to be working with Qt 5.5
 *
 * Copyright (c) 2016, Alexander Borodin, aborod@petrsu.ru
 *
 * This code is licensed under MIT-style license
 */

import QtQuick 2.5
import QtQuick.Layouts 1.0

Item {
    id: gameplay

    width: 800
    height: 600

    property int rounds: 3
    property int roundsLeft: rounds
    property int human: 0
    property int computer: 0

    property bool moveWaiting: true

    signal gameStopped

    Scene {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: - parent.height / 4
        height: 240
        width: 480
        visible: parent.moveWaiting

        onSelected: {
            moveWaiting = false
            banner.human = type
            banner.computer = Math.floor(Math.random() * 3)

            if (banner.human === banner.computer) {
                parent.human++
                parent.computer++
            } else if ((banner.human === 0 ? 3 : banner.human) - banner.computer === 1) {
                parent.human++
            } else if ((banner.computer === 0 ? 3 : banner.computer) - banner.human === 1) {
                parent.computer++
            }

            roundsLeft--
        }
    }

    Tablo {
        id: h
        width: 100
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: parent.human
    }

    Tablo {
        id: info
        width: 100
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: parent.roundsLeft
    }

    Tablo {
        id: c
        width: 100
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        text: parent.computer
    }

    Banner {
        id: banner
        visible: !moveWaiting
        width: 400
        height: 240
        anchors.centerIn: parent
        anchors.verticalCenterOffset: parent.height / 4

        onClicked: {
            if (roundsLeft > 0 )
                moveWaiting = true
            else
                parent.gameStopped()
        }

        Tablo {
            anchors.centerIn: parent
            width: 300
            height: 40
            visible: roundsLeft === 0
            onVisibleChanged: {
                if (visible === true) {
                    if (gameplay.human > gameplay.computer)
                        text = "You win"
                    if (gameplay.human < gameplay.computer)
                        text = "You lose"
                    if (gameplay.human === gameplay.computer)
                        text = "Draw"
                }
            }
        }
    }

    onVisibleChanged: {
        roundsLeft = rounds
        human = 0
        computer = 0
        moveWaiting = true
    }
}
