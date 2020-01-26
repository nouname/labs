/**
 * Menu.qml - A part of the implementation of the RoShamBo
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
    id: menu

    signal gameStarted
    signal optionsSelected

    ColumnLayout {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: parent.height / 4
        spacing: 5

        Button {
            text: "Начать игру"
            onClicked: menu.gameStarted()
        }

        Button {
            text: "Настройки"
            onClicked: menu.optionsSelected()
        }

        Button {
            text: "Выход"
            onClicked: {
                Qt.quit()
            }
        }
    }
}
