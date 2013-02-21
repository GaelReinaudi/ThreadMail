import QtQuick 2.0
import QtGraphicalEffects 1.0
import basalt.Message 1.0
import basalt.Conversation 1.0

Rectangle {


	width: 800
	height: 800

	function addAuthor(text) {
		threadPane.add();
	}
	function addMessage() {
		scroller.height = listttt.height / listttt.contentHeight * scroller.parent.height;
	}



	Row {
		anchors.fill: parent
		spacing: 2
		Rectangle {
			color: Qt.rgba(0.9, 0.9, 0.9, 1);
			width: parent.width * 0.35;
			height: parent.height;

			Image{
				anchors.fill: parent
				source: "qrc:/background.png"
			}

			Column {
				anchors.fill: parent
				GridView {
					id: authorGrid
					width: parent.width;
					height: 30;
					model: conv.authors
					delegate: Rectangle {
						width: (parent.width) / 4
						height: 30
						color: "orange"
						radius: 6
						antialiasing: true
						Text {
							id: authText
							anchors.centerIn: parent
							text: model.modelData
						}
					}
				}

				ListView {
					id: threadList
					model: conv.messages
					width: parent.width;
					height: parent.height - authorGrid.height
					anchors.margins: 1
					spacing: 0
					delegate: Rectangle {
						id:bbb
						width: threadList.width
						height: threadList.height * model.modelData.ratio
						color: "transparent"
						objectName: model.modelData.author
						border.width: 1
						border.color: "purple"
						GridView {
							anchors.fill: parent
							model: conv.authors
							delegate: Rectangle {
								width: 60
								height: parent.parent.height
								color: "transparent"
								radius: 10
								antialiasing: true
								Component.onCompleted: {
									if(bbb.objectName == model.modelData)
										color = "red"
								}
							}
						}
					}
					Rectangle {
						id: scroller
						width: parent.width;
						//height: listttt.height / listttt.contentHeight * scroller.parent.height;
						color: Qt.rgba(0.95, 0.95, 0.95, 0.3)
						MouseArea {
							anchors.fill: parent
							drag.target: scroller
							drag.axis: Drag.YAxis
							drag.minimumY: 0
							drag.maximumY: parent.parent.height - scroller.height
						}
						onYChanged: {
							//var p = listttt.itemAt(0, y / parent.height * listttt.height / listttt.visibleArea.heightRatio);
							//listttt.positionViewAtIndex(p, ListView.Center );
							listttt.contentY = y / (threadList.height - scroller.height) * listttt.height / 0.35;
						}
					}
				}
			}
		}

		Rectangle {
			id: messagePane
			color: Qt.rgba(0.9, 0.9, 0.9, 1);
			width: parent.width * 0.65;
			height: parent.height;

			ListView {
				id: listttt
				model: conv.messages
				anchors.fill: parent
				anchors.margins: 15
				spacing: 15

				delegate: Rectangle {
					width: parent.width
					height: bodyText.height
					color: "transparent"
					Rectangle {
						id: hhh
						x: 5
						y: 5
						width: parent.width
						height: parent.height
						color: "blue"
					}

					Rectangle {
						id: messageRect
						width: parent.width
						height: bodyText.height
						color: Qt.rgba(0.95, 0.95, 0.95, 1)
						radius: 20
						antialiasing: true

						Text {
							id: bodyText
							anchors.left: parent.left
							anchors.right: parent.right
							anchors.rightMargin: 10
							anchors.leftMargin: 10
							//width: parent.width
							wrapMode: Text.Wrap
							text: model.modelData.body
							font.family: "Helvetica neue"
							font.weight: Font.Light
						}
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
				Keys.onSpacePressed: listttt.model.insert(0, { "name": "Item " + model.count })
			}
		}
	}


	//	MouseArea {
	//		anchors.fill: parent
	//		onClicked: {
	//			Qt.quit()
	//		}
	//	}

	Component.onCompleted: {
		//listttt.model = conv.messages
		threadPane.model = conv.messages
	}

}
