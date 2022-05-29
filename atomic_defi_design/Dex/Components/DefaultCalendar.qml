import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import Qaterial 1.0 as Qaterial

import Dex.Themes 1.0 as Dex

Calendar
{
    width: 300
    height: 450
    style: CalendarStyle
    {
        gridColor: "transparent"
        gridVisible: false

        background: DefaultRectangle
        {
            color: Dex.CurrentTheme.floatingBackgroundColor
            radius: 18
        }

        navigationBar: DefaultRectangle
        {
            height: 40
            color: Dex.CurrentTheme.floatingBackgroundColor
            radius: 18

            Qaterial.Button
            {
                id: previousYear
                width: previousMonth.width + 10
                height: width
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                icon.source: Qaterial.Icons.arrowLeft
                onClicked: control.showPreviousYear()
                outlinedColor: "transparent"
                outlined: false
                backgroundColor: "transparent"
            }

            Qaterial.Button
            {
                id: previousMonth
                width: parent.height
                height: width
                anchors.left: previousYear.right
                anchors.leftMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                icon.source: Qaterial.Icons.arrowLeft
                onClicked: control.showPreviousMonth()
                outlinedColor: "transparent"
                outlined: false
                backgroundColor: "transparent"
            }

            DefaultText
            {
                id: dateText
                text: styleData.title
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: previousMonth.right
                anchors.leftMargin: 2
                anchors.right: nextMonth.left
                anchors.rightMargin: 2
            }

            Qaterial.Button
            {
                id: nextYear
                width: nextMonth.width + 10
                height: width
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                icon.source: Qaterial.Icons.arrowRight
                onClicked: control.showNextYear()
                outlinedColor: "transparent"
                outlined: false
                backgroundColor: "transparent"
            }

            Qaterial.Button
            {
                id: nextMonth
                width: parent.height
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: nextYear.left
                anchors.rightMargin: 2
                icon.source: Qaterial.Icons.arrowRight
                onClicked: control.showNextMonth()
                outlinedColor: "transparent"
                outlined: false
                backgroundColor: "transparent"
            }
        }

        dayDelegate: DefaultRectangle
        {
            anchors.fill: parent
            color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "transparent"

            readonly property bool addExtraMargin: control.frameVisible && styleData.selected
            readonly property color sameMonthDateTextColor: Dex.CurrentTheme.foregroundColor
            readonly property color selectedDateColor: Dex.CurrentTheme.buttonColorPressed
            readonly property color selectedDateTextColor: Dex.CurrentTheme.foregroundColor
            readonly property color differentMonthDateTextColor: Dex.CurrentTheme.foregroundColor3
            readonly property color invalidDateColor: Dex.CurrentTheme.textDisabledColor
            DefaultText
            {
                id: dayDelegateText
                text: styleData.date.getDate()
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignRight
                font.pixelSize: Math.min(parent.height/3, parent.width/3)
                color: {
                    var theColor = invalidDateColor;
                    if (styleData.valid) {
                        // Date is within the valid range.
                        theColor = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                        if (styleData.selected)
                            theColor = selectedDateTextColor;
                    }
                    theColor;
                }
            }
        }
    }
}
