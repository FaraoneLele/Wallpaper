import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.0 as ListItem
import "../components"
import "../js/scripts.js" as Scripts

Page {
    id: collectionsPage
    title: i18n.tr("Collections")
    head {
        actions: [searchAction]
    }

    function get_list() {
        Scripts.get_collections()
    }

    ListModel {
        id: collectionsModel
    }

    BouncingProgressBar {
        anchors.top: parent.top
        z: 10000
        visible: collectionsView.status == false
    }

    ListView {
        id: collectionsView
        anchors.fill: parent
        model: collectionsModel
        clip: true

        property bool status : false

        delegate: ListItem.Empty {
            width: parent.width
            height: units.gu(5)
            Item {
                id: delegateitem
                width: parent.wnidth
                height: parent.height
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: units.gu(2)
                    rightMargin: units.gu(2)
                }

                Label {
                    anchors.top: parent.top
                    anchors.topMargin: units.gu(1)
                    text: i18n.tr(name)
                }
            }

            onClicked: {
                collectionPage.title = i18n.tr(name);
                collectionpage.page = 1;
                collectionpage.collection = nid;
                collectionpage.get_wallpapers()
                pagestack.push(collectionPage);
            }
        }
    }
}
