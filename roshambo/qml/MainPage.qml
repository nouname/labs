/**
 * roshambo.qml - An incredible implementation of the RoShamBo
 * (Rock-Paper-Scissors game) with QtQuick technology
 *
 * This code is verified to be working with Qt 5.5
 *
 * Copyright (c) 2016, Alexander Borodin, aborod@petrsu.ru
 *
 * This code is licensed under MIT-style license
 */

import QtQuick 2.5
import QtQuick.Window 2.2
import Sailfish.Silica 1.0

Page {
    id: window

    Item {
        width: window.width
        height: window.height

        Image {
            anchors.fill: parent
            source: "images/wallpaper.jpg"
            fillMode: Image.PreserveAspectCrop
        }

        Menu {
            id: menu
            anchors.fill: parent
            onGameStarted: parent.state = "gameplay"
            onOptionsSelected: parent.state = "options"
        }

        Gameplay {
            id: gameplay
            anchors.fill: parent
            rounds: options.rounds
            onGameStopped: parent.state = "menu"
        }

        Options {
            id: options
            anchors.fill: parent
            onOptionsExit: parent.state = "menu"
        }

        states: [
            State {
                name: "menu"
                PropertyChanges {target: menu; visible: true}
                PropertyChanges {target: gameplay; visible: false}
                PropertyChanges {target: options; visible: false}
            },
            State {
                name: "gameplay"
                PropertyChanges {target: menu; visible: false}
                PropertyChanges {target: gameplay; visible: true}
                PropertyChanges {target: options; visible: false}
            },
            State {
                name: "options"
                PropertyChanges {target: menu; visible: false}
                PropertyChanges {target: gameplay; visible: false}
                PropertyChanges {target: options; visible: true}
            }
        ]

        state: "menu"
    }
}

