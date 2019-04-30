import QtQuick 2.0
import QtQuick.Controls 1.4

import QtFirebase 1.0

import ".."

Page {
    id: root

    /*
     * Auth example
     */
    Column {
        anchors.centerIn: parent

        Text{
            id: titleText
            //anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text:"Sms authentification"
        }

        Text{
            id: statusText
            //anchors.top: titleText.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            Component.onCompleted: {
                if(auth.running) {
                    text = "running"
                } else {
                    if(auth.signedIn) {
                        statusText.text = "Authentification success";
                        statusText.text += "\n";
                        statusText.text += "Name: " + displayName();
                        statusText.text += "\n";
                        statusText.text += "Email: " + email();
                        statusText.text += "\n";
                        statusText.text += "Uid: " + uid();
                    } else {
                        statusText.text += "Signed out";
                    }
                }
            }
        }

        Auth {
            id: auth

            onCodeSent: {
                textTest.visible = true
                registerButton.visible = true;
                textTest.text = "123456" //code
            }

            onSignedInChanged: {
                textTest.visible = !auth.signedIn
                registerButton.visible = !auth.signedIn
            }

            onCompleted: {
                if(success) {
                    if(actionId == Auth.ActionSignIn) {
                        statusText.text = "Authentification success";
                        statusText.text += "\n";
                        statusText.text += "Name: " + displayName();
                        statusText.text += "\n";
                        statusText.text += "Email: " + email();
                        statusText.text += "\n";
                        statusText.text += "Uid: " + uid();
                        statusText.text += "\n";
                        statusText.text += "Number: " + number();
                        statusText.text += "\n";
                        statusText.text += "ID: " + id();
                    } else if(actionId == Auth.ActionRegister) {
                        statusText.text = "Registered success";
                    } else if(actionId == Auth.ActionSignOut) {
                        statusText.text = "Signed out";
                    }
                } else {
                    if(actionId == Auth.ActionSignIn) {
                        statusText.text = "Authentification failed";
                    } else if(actionId == Auth.ActionRegister) {
                        statusText.text = "Registration failed";
                    }
                    statusText.text += "\n";
                    statusText.text += errorId()+" "+errorMsg()
                }
            }
        }

        Column {
            id: buttonsAuth

            Button {
                text: "SignIn"
                enabled: !auth.running && !auth.signedIn
                onClicked: {
                    //auth.smsSignIn("+79000000000")
                    auth.googleSignIn()
                }
            }
            Button {
                text: "SignOut"
                enabled: !auth.running && auth.signedIn
                onClicked: {
                    auth.signOut();
                }
            }
            TextField {
                id: textTest
                visible: false
                placeholderText: qsTr("Enter code")
            }

            Button {
                id: registerButton
                text: "Register"
                visible: false
                onClicked: {
                    auth.codeReceived(textTest.text)
                }
            }

        }
    }
}

