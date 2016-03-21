import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 1.3

Page {
    id: aboutPage
    title: i18n.tr("About")
    head {
        sections {
            actions: [
                Action {
                    text: i18n.tr("About")
                    onTriggered: {
                        tabView.currentIndex = 0;
                    }
                },
                Action {
                    text: i18n.tr("Credits")
                    onTriggered: {
                        tabView.currentIndex = 1;
                    }
                }
            ]
        }
    }

    ListModel {
        id: contributorsModel
        ListElement { name: "Turan Mahmudov"; email: "turan.mahmudov@gmail.com"; role: "Creator" }
        ListElement { name: "Turan Mahmudov"; email: "turan.mahmudov@gmail.com"; role: "Developers" }
        ListElement { name: "Mkay Naut"; email: ""; role: "Logo" }
    }

    ListView {
        id: tabView
        model: tabs
        interactive: false
        anchors.fill: parent
        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        currentIndex: 0
        highlightMoveDuration: UbuntuAnimation.SlowDuration
    }

    VisualItemModel {
        id: tabs

        Item {
            width: tabView.width
            height: tabView.height

            Column {
                spacing: units.gu(4)
                anchors {
                    left: parent.left;
                    right: parent.right;
                    top: parent.top
                    margins: units.gu(2)
                    topMargin: units.gu(5)
                }

                UbuntuShape {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: units.gu(16)
                    height: units.gu(16)
                    radius: "medium"
                    source: Image {
                        source: Qt.resolvedUrl("../Wallpapers.png")
                    }
                }

                Column {
                    width: parent.width
                    spacing: units.gu(0.5)

                    Label {
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "<b>Wallpapers</b> " + current_version
                        fontSize: "large"
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Label {
                        width: parent.width
                        text: i18n.tr("Powered by <b>Wallpaper Abyss</b>")
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }
                }

                Column {
                    width: parent.width

                    Label {
                        text: "(C) 2016 Turan Mahmudov"
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        fontSize: "small"
                    }

                    Label {
                        text: "<a href=\"mailto://turan.mahmudov@gmail.com\">turan.mahmudov@gmail.com</a>"
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        linkColor: UbuntuColors.orange
                        fontSize: "small"
                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    Label {
                        text: i18n.tr("Released under the terms of the GNU GPL v3")
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        fontSize: "small"
                    }
                }

                Label {
                    text: i18n.tr("Source code available on %1").arg("<a href=\"https://github.com/turanmahmudov/Wallpaper\">Github</a>")
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    linkColor: UbuntuColors.orange
                    fontSize: "small"
                    onLinkActivated: Qt.openUrlExternally(link)
                }

            }
        }

        Item {
            width: tabView.width
            height: tabView.height

            ListView {
                id: contributorsList
                clip: true
                anchors.fill: parent
                model: contributorsModel
                section.property: "role"
                section.labelPositioning: ViewSection.InlineLabels

                section.delegate: ListItem.Empty {
                    showDivider: true
                    height: headerText.implicitHeight + units.gu(1)
                    Label {
                        id: headerText
                        text: i18n.tr(section)
                        fontSize: 'small'
                        font.bold: true
                        anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter;
                                    leftMargin: units.gu(2); rightMargin: units.gu(1); topMargin: units.gu(0.5);
                                    bottomMargin: units.gu(0.5)
                        }
                    }
                }

                delegate: ListItem.Empty {
                    showDivider: contributorsModel.get(index+1) ? (contributorsModel.get(index+1).role == contributorsModel.get(index).role ? true : false) : false
                    height: mainColumn1.height + units.gu(3)
                    Column {
                        id: mainColumn1
                        anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter;
                                    leftMargin: units.gu(2); rightMargin: units.gu(2);
                        }

                        Label {
                            text: name
                            width: parent.width
                            elide: Text.ElideRight
                        }

                        Label {
                            id: emailLabel
                            visible: email ? true : false
                            text: '<a href=\"mailto:' + email + '\">' + email + '</a>'
                            linkColor: UbuntuColors.orange
                            fontSize: "small"
                            width: parent.width
                            elide: Text.ElideRight
                            onLinkActivated: Qt.openUrlExternally(link)
                        }
                    }
                    onClicked: {
                        if (email) {
                            Qt.openUrlExternally("mailto:"+email)
                        }
                    }
                }
            }
        }
    }
}
