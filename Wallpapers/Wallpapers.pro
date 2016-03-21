TEMPLATE = aux
TARGET = Wallpapers

RESOURCES += Wallpapers.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

CONF_FILES +=  Wallpapers.apparmor \
               Wallpapers.png

AP_TEST_FILES += tests/autopilot/run \
                 $$files(tests/*.py,true)               

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
               Wallpapers.desktop

#specify where the qml/js files are installed to
qml_files.path = /Wallpapers
qml_files.files += $${QML_FILES}

components_files.path = /Wallpapers/components
components_files.files += $${QML_FILES}

ui_files.path = /Wallpapers/ui
ui_files.files += $${QML_FILES}

js_files.path = /Wallpapers/js
js_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /Wallpapers
config_files.files += $${CONF_FILES}

#install the desktop file, a translated version is 
#automatically created in the build directory
desktop_file.path = /Wallpapers
desktop_file.files = $$OUT_PWD/Wallpapers.desktop
desktop_file.CONFIG += no_check_exist

INSTALLS+=config_files qml_files components_files ui_files js_files desktop_file

DISTFILES += \
    components/BouncingProgressBar.qml \
    components/ContentDownloadDialog.qml \
    ui/About.qml \
    ui/Categories.qml \
    ui/Category.qml \
    ui/Photo.qml \
    ui/Search.qml \
    ui/Wallpapers.qml \
    js/scripts.js \
    ui/Collections.qml \
    ui/Collection.qml

