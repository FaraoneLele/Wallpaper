import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Components.Popups 1.3
import "../components"
import "../js/scripts.js" as Scripts

Item {
    id: collectionPage

    property int page: 1
    property string collection: "0"

    function get_wallpapers(clr) {
        Scripts.get_wallpapers(page, "0", clr, collection)
    }

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

        property bool status : false

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
            get_wallpapers('false')
        }
    }
}
