import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire

ShellRoot {
    id: root

    property var sink: Pipewire.defaultAudioSink
    readonly property real vol: sink && sink.audio ? sink.audio.volume : 0
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    property bool armed: false
    property bool showBar: false

    PwObjectTracker { objects: [root.sink] }
    SystemPalette { id: pal }

    Timer { interval: 1000; running: true; onTriggered: root.armed = true }
    Timer { id: hideTimer; interval: 1000; onTriggered: root.showBar = false }

    function poke() {
        if (!armed) return
        showBar = true
        hideTimer.restart()
    }

    onVolChanged: poke()
    onMutedChanged: poke()

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            visible: root.muted || root.showBar
            color: "transparent"
            anchors.top: true
            margins.top: 40
            implicitWidth: 320
            implicitHeight: 32
            exclusionMode: ExclusionMode.Ignore
            mask: Region {}

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "volume-osd"

            Row {
                anchors.centerIn: parent
                spacing: 8

                Rectangle {
                    visible: root.muted
                    width: 32; height: 32; radius: 16
                    color: pal.window
                    border.color: pal.mid

                    Canvas {
                        anchors.centerIn: parent
                        width: 18; height: 18
                        onPaint: {
                            var c = getContext("2d")
                            c.clearRect(0, 0, width, height)
                            c.fillStyle = pal.windowText
                            c.strokeStyle = pal.windowText
                            c.lineWidth = 2
                            c.beginPath()
                            c.moveTo(1, 6); c.lineTo(5, 6); c.lineTo(10, 2)
                            c.lineTo(10, 16); c.lineTo(5, 12); c.lineTo(1, 12)
                            c.closePath()
                            c.fill()
                            c.beginPath()
                            c.moveTo(12, 6); c.lineTo(17, 12)
                            c.moveTo(17, 6); c.lineTo(12, 12)
                            c.stroke()
                        }
                        Component.onCompleted: requestPaint()
                    }
                }

                Rectangle {
                    visible: root.showBar
                    width: 240; height: 32; radius: 16
                    color: pal.window
                    border.color: pal.mid

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        x: 12
                        width: parent.width - 24
                        height: 8; radius: 4
                        color: pal.mid

                        Rectangle {
                            width: parent.width * Math.max(0, Math.min(1, root.vol))
                            height: parent.height; radius: 4
                            color: root.muted ? pal.dark : pal.highlight
                        }
                    }
                }
            }
        }
    }
}
