import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Components.Popups 1.3
import "../components"
import "../js/scripts.js" as Scripts

Page {
    id: searchPage
    title: i18n.tr("Search")
    head.contents: TextField {
        id: searchField
        anchors {
            right: parent.right
            rightMargin: units.gu(2)
        }
        hasClearButton: true
        inputMethodHints: Qt.ImhNoPredictiveText
        placeholderText: i18n.tr("Search")
        onVisibleChanged: {
            if (visible) {
                forceActiveFocus()
            }
        }
        onAccepted: {
            term = searchField.text
            Scripts.get_search(page, term)
        }
    }

    property int page: 1
    property string term: ""

    ListModel {
        id: wallpapersModel
    }

    BouncingProgressBar {
        anchors.top: parent.top
        z: 10000
        visible: wallpapersView.status == false
    }

    GridView {
        id: wallpapersView
        anchors {
            margins: 0
            top: parent.top
            left: parent.left
        }
        clip: true
        z: 1
        width: parent.width
        height: parent.height - units.gu(6)
        cellWidth: mainView.width > units.gu(60) ? (parent.width/4) : (parent.width/3)
        cellHeight: cellWidth*3/4
        model: wallpapersModel

        property bool status : true

        delegate: ListItem.Empty {
            width: parent.width
            height: wallpapersView.cellHeight
            showDivider: false
            Item {
                id: delegateitem
                width: wallpapersView.cellWidth
                height: wallpapersView.cellHeight
                Image {
                    id: wimage
                    width: parent.width
                    height: parent.height
                    source: image
                    clip: true
                    cache: true
                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                }
            }

            onClicked: {
                photoPage.title = i18n.tr("Photo");
                photopage.photo(id, image, big_image);
                pagestack.push(photoPage);
            }
        }
    }

    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: wallpapersView.bottom
        anchors.topMargin: units.gu(1)
        text: i18n.tr("Load more")
        onClicked: {
            page = page + 1
            Scripts.get_search(page, term, 'false')
        }
    }
}
