/**
 * Scene.qml - A part of the implementation of the RoShamBo
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

RowLayout {
    spacing: 20

    signal selected(int type)

    Hand {
        type: 0
        width: (parent.width - 4 * spacing) / 3
        onClicked: selected(0)
    }
    Hand {
        type: 1
        width: (parent.width - 4 * spacing) / 3
        onClicked: selected(1)
    }
    Hand {
        type: 2
        width: (parent.width - 4 * spacing) / 3
        onClicked: selected(2)
    }
}

