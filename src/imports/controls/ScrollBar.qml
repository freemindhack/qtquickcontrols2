/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.6
import QtQuick.Controls 2.0

AbstractScrollBar {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            handle.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             handle.implicitHeight + topPadding + bottomPadding)

    Accessible.pressed: pressed
    Accessible.role: Accessible.ScrollBar

    padding: 2

    handle: Rectangle {
        id: handle

        implicitWidth: 6
        implicitHeight: 6

        radius: width / 2
        color: control.pressed ? style.shadowColor : style.frameColor
        visible: control.size < 1.0
        opacity: 0.0

        readonly property bool horizontal: control.orientation === Qt.Horizontal
        x: control.leftPadding + (horizontal ? control.position * control.width : 0)
        y: control.topPadding + (horizontal ? 0 : control.position * control.height)
        width: horizontal ? control.size * control.width - control.leftPadding - control.rightPadding : implicitWidth
        height: horizontal ? implicitHeight : control.size * control.height - control.topPadding - control.bottomPadding

        states: State {
            name: "active"
            when: control.active
            PropertyChanges { target: handle; opacity: 1.0 - style.disabledOpacity }
        }

        transitions: Transition {
            from: "active"
            SequentialAnimation {
                PauseAnimation { duration: 450 }
                NumberAnimation { target: handle; duration: 200; property: "opacity"; to: 0.0 }
            }
        }
    }
}
