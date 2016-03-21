import QtQuick 2.0
import Ubuntu.Components 1.3
import Ubuntu.DownloadManager 1.2
import Ubuntu.Content 1.1
import Ubuntu.Components.Popups 1.3
import "../js/scripts.js" as Scripts

Item {
    id: photoItem

    property var photoUrl

    function photo(id, thumb, image) {
        //var newurl = url.replace("thumb-", "");

        photoUrl = image;
        photo.source = thumb;
    }

    Image {
        id: photo
        width: parent.width
        height: width*3/4
    }

    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: photo.bottom
        anchors.topMargin: units.gu(1)
        text: i18n.tr("Download")
        onClicked: {
            var singleDownload = downloadComponent.createObject(mainView)
            singleDownload.contentType = ContentType.Pictures
            singleDownload.download(photoUrl)
        }
    }
}
