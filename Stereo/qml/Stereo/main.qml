import QtQuick 2.0
import QtGraphicalEffects 1.0
import basalt.Message 1.0
import basalt.Conversation 1.0

Rectangle {

	width: 800
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
			color: Qt.rgba(0.8, 0.8, 0.8, 1);
			width: parent.width / 2;
			height: parent.height;

			ListView {
				id: listttt
				anchors.fill: parent
				anchors.margins: 5
				spacing: 5

				delegate: Rectangle {
					id: messageRect
					width: parent.width
					height: childrenRect.height
					color: Qt.rgba(0.9, 0.9, 0.9, 1)
					radius: 2
					antialiasing: true

					Text {
						anchors.left: parent.left
						anchors.right: parent.right
						anchors.rightMargin: 5
						anchors.leftMargin: 5
						id: bodyText
						//width: parent.width
						text: model.modelData.body
						wrapMode: Text.Wrap
					}
				}

				add: Transition {
					NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
					NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
				}

				displaced: Transition {
					NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
				}

				focus: true
				Keys.onSpacePressed: model.insert(0, { "name": "Item " + model.count })
			}
		}
	}

	Text {
		id: textttt
		text: "Hello"
		//text: thread.messages[0].body;
		color: "white"
		anchors.centerIn: parent
	}


	MouseArea {
		anchors.fill: parent
		onClicked: {
			listttt.model = conv.messages
//			Qt.quit();
		}
	}

}
