import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.DownloadManager 1.2
import Ubuntu.Content 1.1
import Ubuntu.Components.Popups 1.3
import "components"
import "ui"
import "js/scripts.js" as Scripts

MainView {
    id: mainView

    objectName: "mainView"
    applicationName: "wallpapers.turan-mahmudov-l"

    automaticOrientation: true

    width: units.gu(50)
    height: units.gu(75)

    property int filter_by: 0
    property string current_version: "0.3.2"
    property string auth_key: "414aeb60c70011bdfae360000d9bc353"
    property string api_url: 'https://wall.alphacoders.com/api2.0/get.php'

    property int res_index: 0
    property string res_width: ""
    property string res_height: ""

    // Main Actions for page header
    actions: [
        Action {
            id: searchAction
            text: i18n.tr("Search")
            iconName: "search"
            onTriggered: {
                pagestack.push(Qt.resolvedUrl("ui/Search.qml"))
            }
        },
        Action {
            id: filterAction
            text: i18n.tr("Filter")
            iconName: "filters"
            onTriggered: {
                PopupUtils.open(filterDialog)
            }
        },
        Action {
            id: resAction
            text: i18n.tr("Resolution")
            iconName: "crop"
            onTriggered: {
                PopupUtils.open(resDialog)
            }
        }
    ]

    function home() {
        pagestack.push(tabs)

        wallpapersTab.get_wallpapers()
    }

    PageStack {
        id: pagestack

        Component.onCompleted: {
            home()
        }
    }

    Tabs {
        id: tabs
        visible: false

        Tab {
            title: i18n.tr("Wallpapers")
            Wallpapers {
                id: wallpapersTab
            }
        }

        Tab {
            title: i18n.tr("Categories")
            Categories {
                id: categoriesTab
            }

            Component.onCompleted: {
                categoriesTab.get_list()
            }
        }

        Tab {
            title: i18n.tr("Collections")
            Collections {
                id: collectionsTab
            }

            Component.onCompleted: {
                collectionsTab.get_list()
            }
        }

        Tab {
            title: i18n.tr("About")
            About {
                id: aboutTab
            }
        }
    }

    Page {
        id: photoPage
        visible: false
        title: i18n.tr("Photo")

        Photo {
            id: photopage
            anchors.fill: parent
        }
    }

    Page {
        id: categoryPage
        visible: false
        title: i18n.tr("Category")
        head {
            actions: [searchAction, resAction]
        }

        Category {
            id: categorypage
            anchors.fill: parent
        }
    }

    Page {
        id: collectionPage
        visible: false
        title: i18n.tr("Collection")
        head {
            actions: [searchAction, resAction]
        }

        Collection {
            id: collectionpage
            anchors.fill: parent
        }
    }

    Component {
        id: downloadDialog
        ContentDownloadDialog { }
    }

    Component {
        id: filterDialog
        Dialog {
            id: dialog

            OptionSelector {
                id: optionSelector
                expanded: true
                selectedIndex: filter_by
                model: [
                    i18n.tr("Featured"),
                    i18n.tr("Newest"),
                    i18n.tr("Highest rated"),
                    i18n.tr("By views"),
                    i18n.tr("By favorites"),
                ]
                onDelegateClicked: {
                    filter_by = index

                    wallpapersTab.page = 1
                    wallpapersTab.get_wallpapers()

                    PopupUtils.close(dialog);
                }
            }
        }
    }

    Component {
        id: resDialog
        Dialog {
            id: dialog

            OptionSelector {
                id: optionSelector
                expanded: true
                selectedIndex: res_index
                model: [
                    i18n.tr("All"),
                    i18n.tr("HD Wallpapers"),
                    i18n.tr("UltraHD 4k Wallpapers"),
                    i18n.tr("Retina 5k Wallpapers")
                ]
                onDelegateClicked: {
                    res_index = index
                    switch (index) {
                        case 0:
                            res_width = "";
                            res_height = "";
                            break;
                        case 1:
                            res_width = "1920";
                            res_height = "1080";
                            break;
                        case 2:
                            res_width = "3840";
                            res_height = "2160";
                            break;
                        case 3:
                            res_width = "5120";
                            res_height = "2880";
                            break;
                    }

                    wallpapersTab.page = 1
                    wallpapersTab.get_wallpapers()

                    categorypage.page = 1
                    categorypage.get_wallpapers()

                    collectionpage.page = 1
                    collectionpage.get_wallpapers()

                    PopupUtils.close(dialog);
                }
            }
        }
    }

    Component {
        id: downloadComponent
        SingleDownload {
            autoStart: false
            property var contentType
            onDownloadIdChanged: {
                PopupUtils.open(downloadDialog, mainView, {"contentType" : contentType, "downloadId" : downloadId})
            }

            onFinished: {
                destroy()
            }
        }
    }
}
