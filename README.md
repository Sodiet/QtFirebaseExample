<img src="https://github.com/Larpon/QtFirebase/blob/master/logo.png" align="right"/>
# QtFirebaseExample

# Social Sign-In

    1. Download QtFirebase Example and QtFirebase
    2. Download Firebase C++ SDK and unzip it to "QtFirebaseExample/extensions" ("extensions/firebase_cpp_sdk/{folders Android, frameworks and others}")
    3. Run "extensions/QtFirebase/src/ios/download_sdks.sh"

Dont forget create IOS and Android app from Firebase Console.

Firebase Console -> Authenticaion -> Sign-in method -> Enable Google, FacebookSDKs:

  For Google:
  
    1. Upload SHA-1 to Firebase Console (https://developers.google.com/android/guides/client-auth), different for debug and release
    
  For Facebook:
  
    1. App ID and App secret from Facebook Console
    2. Copy OAuth redirect URI to Facebook Console

  For Google:
  
    1. Open GoogleService-Info.plist, get REVERSED_CLIENT_ID's key. Paste it to URL Schemes
    2. Edit "extensions/QtFirebase/src/ios/appdelegate.mm", paste CLIENT_ID from GoogleService-Info.plist to googleClientID
    3. Check applicationId at build.gradle
    4. Check firebase_cpp_sdk_dir at gradle.properties
    5. Put CLIENT_ID from GoogleService-Info.plist to requestIdToken at ""QtFirebaseExample/App/platforms/android/src/com/blackgrain/android/firebasetest/QtFirebaseAuthActivity.java"


  For Facebook:
  
    1. Add to Info.plist
    
    <key>LSApplicationQueriesSchemes</key>
    	<array>
    		<string>fbapi</string>
    		<string>fb-messenger-share-api</string>
    		<string>fbauth2</string>
    		<string>fbshareextension</string>
    	</array>

    2. Add to URL Schemes fb{FacebookAppID};
    3. Open "QtFirebaseExample/App/platforms/android/src/com/blackgrain/android/firebasetest/Main.java". Insert to setApplicationId fb{FacebookAppID}
    
    
   If there is any error like "expected ')'" or "Parse error", then open file "extensions/QtFirebase/src/ios/Firebase/AdMob/GoogleMobileAds.framework/Headers/RTBMediation/GADRTBAdapter.h" and add "#undef signals" to beginning of file, then add "#define signals Q_SIGNALS"
   
   Error, when Qt can't find apk, uncomment 	gradle.projectsEvaluated at buil.gradle
   
   Shorter build's directory path - better


# QtFirebaseExample
Example Qt app for the QtFirebase project

# Quick start


1. Clone the example app and the [QtFirebase](https://github.com/Larpon/QtFirebase) project

  * **Clone example project**

    ```
    cd /path/to/projects
    git clone git@github.com:Larpon/QtFirebaseExample.git
    ```
  * **Clone the QtFirebase project**

    Clone into the "extensions" folder or into other folder of your choice
    ```
    cd /path/to/projects/QtFirebaseExample/extensions
    git clone git@github.com:Larpon/QtFirebase.git
    ```

2. Follow the instructions in [SETUP.md](https://github.com/Larpon/QtFirebase/blob/master/SETUP.md) on how to setup QtFirebase
