import QtQuick 2.0

Rectangle {

	width: 200
	height: 800

	Image{
		anchors.fill: parent
		source: "qrc:/background.png"
	}

	Text {
		text: qsTr("Hello Worlddd")
        color: "white"
		anchors.centerIn: parent
	}


	MouseArea {
		anchors.fill: parent
		onClicked: {
			Qt.quit();
		}
	}

}
