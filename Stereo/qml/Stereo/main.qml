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
//		scroller.height = listttt.height / listttt.contentHeight * scroller.parent.height;
	}



	Row {
		anchors.fill: parent
		spacing: 2
		Rectangle {
			color: Qt.rgba(0.9, 0.9, 0.9, 1);
            width: 200;
			height: parent.height;

//			Image{
//				anchors.fill: parent
//				source: "qrc:/background.png"
//			}

			Column {
				anchors.fill: parent
				GridView {
					id: authorGrid
                    width: parent.width;
					height: 30;
                    model: conv.authors
					delegate: Rectangle {
                        width: (parent.width) / 3
                        height: 20
                        color: Qt.rgba(0.95, 0.95, 0.95, 1)
                        radius: 2
						antialiasing: true
						Text {
							id: authText
                            anchors.centerIn: parent
                            text: model.modelData
                            font.family: "Helvetica neue"
                            font.weight: Font.Light
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
						GridView {
							anchors.fill: parent
							model: conv.authors
                            delegate: Rectangle {
								width: 60
								height: parent.parent.height
								color: "transparent"
                                radius: 2
								antialiasing: true
								Component.onCompleted: {
									if(bbb.objectName == model.modelData)
                                        color = Qt.rgba(0.5, 0.5, 0.5, 1)
								}
							}
						}
					}
					Rectangle {
						id: scroller
						width: parent.width;
						//height: listttt.height / conv.length * threadList.height;
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
							listttt.contentY = y / (threadList.height - scroller.height) * (conv.length - listttt.height) // 3.2;
						}
					}
				}
			}
		}

		Rectangle {
			id: messagePane
			color: Qt.rgba(0.9, 0.9, 0.9, 1);
            width: parent.width * 600;
			height: parent.height;

			ListView {
				id: listttt
				model: conv.messages
				anchors.fill: parent
				anchors.margins: 15
				spacing: 15
				cacheBuffer: 2000

				delegate: Rectangle {
					id: deleg
					width: parent.width
					height: bodyText.height
					color: "transparent"
//					Rectangle {
//						id: hhh
//						x: 5
//						y: 5
//						width: parent.width
//						height: parent.height
//						color: "transparent"
//					}

					Rectangle {
						id: messageRect
						width: parent.width
						height: bodyText.height
						color: Qt.rgba(0.95, 0.95, 0.95, 1)
                        radius: 4
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
					Component.onCompleted: {
						model.modelData.length = messageRect.height + 13//parent.spacing;
						scroller.height = listttt.height / conv.length * threadList.height
					}

					DropShadow {
                        width: deleg.width
                        height: deleg.height
                        horizontalOffset: 0
                        verticalOffset: 2
                        radius: 2
						samples: 16
						//fast: true
						//transparentBorder : true
                        color: Qt.rgba(0, 0, 0, 0.2)
						source: messageRect
						cached: true
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
