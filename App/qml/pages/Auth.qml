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
            text:"Social auth"
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
                smsCodeText.visible = true
                registerButton.visible = true;
                phoneNumberText.visible = false;
                smsCodeText.text = "123456" //code
            }

            onSignedInChanged: {
                smsCodeText.visible = !auth.signedIn
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
                text: "SignIn Google"
                enabled: !auth.running && !auth.signedIn
                onClicked: {
                    //auth.smsSignIn("+79000000000")
                    auth.googleSignIn()
                }
            }

            Button {
                text: "SignIn Facebook"
                enabled: !auth.running && !auth.signedIn
                onClicked: {
                    auth.facebookSignIn()
                }
            }
            Button {
                text: "SignIn SMS"
                enabled: !auth.running && !auth.signedIn
                onClicked: {
                    auth.smsSignIn(phoneNumberText.text)
                    registerButton.visible
                }
            }
            Button {
                id: emailButton
                text: "Email SignIn"
                visible: !auth.running && !auth.signedIn
                onClicked: {
                    auth.registerUser("text@mail.com", "1234567")
                }
            }
            TextField {
                id: phoneNumberText
                visible: !auth.running && !auth.signedIn
                placeholderText: qsTr("Enter phone number")
            }

            Button {
                text: "SignOut"
                enabled: !auth.running && auth.signedIn
                onClicked: {
                    auth.signOut();
                    smsCodeText.visible = false
                    registerButton.visible = false
                }
            }
            TextField {
                id: smsCodeText
                visible: false
                placeholderText: qsTr("Enter code")
            }

            Button {
                id: registerButton
                text: "CodeReceived"
                visible: false
                onClicked: {
                    auth.codeReceived(smsCodeText.text)
                    //auth.registerUser("wowr-87@mail.ru", "1234567")
                }
            }
        }
    }
}

