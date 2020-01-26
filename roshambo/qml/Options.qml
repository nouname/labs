/**
 * Options.qml - A part of the implementation of the RoShamBo
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
import Qt.labs.settings 1.0

Item {
    id: options

    property int rounds: settings.rounds

    signal optionsExit

    ColumnLayout {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: parent.height / 4
        spacing: 5

        Input {
            id: input
            number: options.rounds
            text: qsTr("Rounds to win:")
            onNumberChanged: {
                options.rounds = number
            }
        }

        Button {
            text: qsTr("Back to menu")
            onClicked: optionsExit()
        }
    }

    Settings {
        id: settings
        property int rounds: 3
    }

    Component.onDestruction: {
        settings.rounds = rounds
    }

    onRoundsChanged: {
        input.number = rounds
    }
}

