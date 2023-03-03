//
//  AppDelegate.swift
//  UnitFive-BeReal
//
//  Created by Liana Adaza on 2/27/23.
//

import UIKit
import ParseSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // TODO: Pt 1 - Initialize Parse SDK

        // Add the following values from your Parse server.
        // For back4app hosted Parse servers:
        //   - App Settings tab -> Security & Keys -> App Keys -> applicationId + clientKey
        //   - App Settings tab -> App Management -> Parse API Address
        // https://github.com/parse-community/Parse-Swift/blob/main/ParseSwift.playground/Sources/Common.swift
        ParseSwift.initialize(applicationId: "X9Kdvg4DtyODE6Acu2obLQ53k5O2EHl5Kec6w8bT",
                              clientKey: "4dKCNuMClqKL92UphGLwfdfGiEPsVJ9yQQRhz0tG",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)

        // TODO: Pt 1: - Instantiate and save a test parse object to your server
        // https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/1%20-%20Your%20first%20Object.xcplaygroundpage/Contents.swift#L121

//        var score = GameScore()
//        score.playerName = "Kingsley"
//        score.points = 13
//
//        // Save asynchronously (preferred way) - Performs work on background queue and returns to specified callbackQueue.
//        // If no callbackQueue is specified it returns to main queue.
//        score.save { result in
//            switch result {
//            case .success(let savedScore):
//                print("✅ Parse Object SAVED!: Player: \(String(describing: savedScore.playerName)), Score: \(String(describing: savedScore.points))")
//            case .failure(let error):
//                assertionFailure("Error saving: \(error)")
//            }
//        }
        
        // TODO: Users receive a notification to remind them to post.
        // Ask user to give our app permission to send them notifications.
        UNUserNotificationCenter.current().delegate = self
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if granted {
                        print("✅ User gave permissions for local notifications")
                    }
                }
        
        // Configure the notification's content.
        let content = UNMutableNotificationContent()
        content.title = "BeReal"
        content.body = "Remember to upload todays's photo 👀"
        content.sound = UNNotificationSound.default
         
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger) // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
                
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// TODO: Pt 1 - Create Test Parse Object
// https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/1%20-%20Your%20first%20Object.xcplaygroundpage/Contents.swift#L33

// Create your own value typed `ParseObject`.
struct GameScore: ParseObject {
    // These are required by ParseObject
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // Your own custom properties.
    // All custom properties must be optional.
    var playerName: String?
    var points: Int?
}

// Sample Usage
//
// var score = GameScore()
// score.playerName = "Kingsley"
// score.points = 13


// OR Implement a custom initializer (OPTIONAL i.e. NOT REQUIRED)
// It's recommended to place custom initializers in an extension
// to preserve the memberwise initializer.
extension GameScore {

    // Use the init to set your custom properties
    // NOTE: Properties in custom init are NOT required to be optional
    init(playerName: String, points: Int) {
        self.playerName = playerName
        self.points = points
    }
}

// Sample Usage
//
// let score = GameScore(playerName: "Kingsley", points: 13)
