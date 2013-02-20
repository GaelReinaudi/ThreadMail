import QtQuick 2.0

Rectangle {

	width: 500
	height: 800

	Row {
		anchors.fill: parent
		spacing: 2
		Rectangle {
			id: threadPane
			color: "blue";
			width: parent.width / 2;
			height: parent.height;
			Image{
				anchors.fill: parent
				source: "qrc:/background.png"
			}
		}
		Rectangle {
			id: messagePane
			color: "red";
			width: parent.width / 2;
			height: parent.height;
		}
	}

	Text {
		text: qsTr("Hello Worldddd")
		color: "white"
		anchors.centerIn: parent
	}


	MouseArea {
		anchors.fill: parent
		onClicked: {
			thread.messages;
			Qt.quit();
		}
	}

}
