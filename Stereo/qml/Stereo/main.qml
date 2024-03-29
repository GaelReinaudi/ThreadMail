import QtQuick 2.0
import QtGraphicalEffects 1.0
//import QtQuick.Particles 2.0
import basalt.Message 1.0
import basalt.Conversation 1.0

Rectangle {


	width: 800
	height: 800

	function addAuthor(auth) {
		authModel.append({"author": auth})
	}
	function addMessage(authName, messBody) {
		messModel.insert(0, {"author": authName, "body": messBody, "length": 100.0})
	}

	ListModel {
		id: messModel
	}
	ListModel {
		id: authModel
	}

	Row {
		anchors.fill: parent
		spacing: 2
		Rectangle {
			id: threadPane
            color: Qt.rgba(88/255, 153/255, 190/255, 1);
			width: parent.width * 0.35;
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
					model: authModel
					delegate: Rectangle {
						width: (parent.width) / 4
						height: 30
                        color: Qt.rgba(255/255, 216/255, 122/255, 1)
                        radius: 3
						antialiasing: true
						Text {
							id: authText
							anchors.centerIn: parent
							text: model.author
						}
					}
					add: Transition {
						NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 600 }
						NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 600 }
					}
				}

				ListView {
					id: threadList
					model: messModel
					width: parent.width;
					height: parent.height - authorGrid.height
					anchors.margins: 1
					spacing: 0
					delegate: Rectangle {
						id:bbb
						width: threadList.width
						height: threadList.height * model.length / conv.length
						color: "transparent"
						objectName: author
						border.width: 1
						border.color: Qt.rgba(0.95, 0.0, 0.95, 0.1)
						GridView {
							anchors.fill: parent
							model: authModel
							delegate: Rectangle {
								id: delegRibbon
								width: (parent.width) / 4
								height: parent.parent.height
								color: "transparent"
								Rectangle {
									id: rectRibbon
									anchors.fill: parent
									color: "transparent"
									radius: 4
									antialiasing: true
									Component.onCompleted: {
										if(bbb.objectName == author)
											color = Qt.rgba(0.95, 0.95, 0.95, 1)
									}
								}
								DropShadow {
									anchors.fill: delegRibbon
									horizontalOffset: 0//1
									verticalOffset: 1
									radius: 2
									samples: 2
									fast: true
									color: "#80000000"
									source: rectRibbon
									cached: true
								}
							}
						}
						Component.onCompleted: {
							//height = threadList.height * model.length / conv.length;
						}
					}
					add: Transition {
						NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 600 }
						SequentialAnimation {
							//NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 100 }
							//ColorAnimation { property: "color"; to: "yellow"; duration: 200 }
							//ColorAnimation { property: "color"; to: "transparent"; duration: 200 }
						}
					}
					displaced: Transition {
						NumberAnimation { properties: "x,y"; duration: 1000; easing.type: Easing.OutBounce }
						NumberAnimation { property: "opacity"; to: 1.0 }
						NumberAnimation { property: "scale"; to: 1.0 }
						//ColorAnimation { property: "color"; to: "transparent"; duration: 400 }
					}
					Rectangle {
						id: scroller
						width: parent.width;
						color: Qt.rgba(0.95, 0.95, 0.95, 0.3)
						MouseArea {
							anchors.fill: parent
							drag.target: scroller
							drag.axis: Drag.YAxis
							drag.minimumY: 0
							drag.maximumY: parent.parent.height - scroller.height
						}
						Text {
							id: dragText
							anchors.centerIn: parent
							text: "drag me"
						}

						onYChanged: {
							listttt.contentY = listttt.originY + y / (threadList.height - scroller.height) * (conv.length - listttt.height);
							dragText.text = ""
						}
					}
				}
			}
		}

		Rectangle {
			id: messagePane
            color: Qt.rgba(188/255, 220/255, 242/255, 1);//Qt.rgba(189/255, 231/255, 255/255, 1);
			width: parent.width - threadPane.width;
			height: parent.height;

			ListView {
				id: listttt
				model: messModel
				anchors.fill: parent
				anchors.margins: 15
				spacing: 15
				cacheBuffer: 20000

				delegate: Rectangle {
					id: deleg
					width: parent.width
					height: bodyText.height
					color: "transparent"

					Rectangle {
						id: messageRect
						width: parent.width
						height: bodyText.height
						color: Qt.rgba(0.95, 0.95, 0.95, 1)
						radius: 3
						antialiasing: true

						Text {
							id: bodyText
							anchors.left: parent.left
							anchors.right: parent.right
							anchors.rightMargin: 10
							anchors.leftMargin: 10
							//width: parent.width
							wrapMode: Text.Wrap
							text: model.body
							font.family: "Helvetica neue"
							font.weight: Font.Light
						}
					}
					Component.onCompleted: {
						messModel.setProperty(index, "length", messageRect.height + 13)
						conv.length = model.length + conv.length;
						scroller.height = listttt.height / conv.length * threadList.height
					}

					DropShadow {
						anchors.fill: deleg
						horizontalOffset: 0//1
						verticalOffset: 2
						radius: 2
						samples: 2
						fast: true
						//transparentBorder : true
						color: "#80000000"
						source: messageRect
						cached: true
					}
				}
				add: Transition {
					NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 600 }
					NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 600 }
				}
				displaced: Transition {
					NumberAnimation { properties: "x,y"; duration: 600; easing.type: Easing.OutBounce }
					NumberAnimation { property: "opacity"; to: 1.0 }
					NumberAnimation { property: "scale"; to: 1.0 }
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
	}

}
