//
//  SceneDelegate.swift
//  ThreadApp
//
//  Created by Shailesh Patel on 05/05/2021.
//

import UIKit

/**
 The `SceneDelegate` class manages the lifecycle of a scene (UI window) in the ThreadApp.
 
 In iOS 13 and later, apps can have multiple scenes (windows) open at once. The `SceneDelegate` handles events related to the scene's state transitions, such as when it becomes active, enters the background, or is disconnected.
 
 - Note: If using storyboards, the `window` property is automatically initialized and attached to the scene.
 */
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    /// The main window associated with this scene.
    var window: UIWindow?

    /**
     Called when the scene is being created and connected to the app.
     
     Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
     If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
     
     - Parameters:
        - scene: The scene object being connected.
        - session: The session associated with the scene.
        - connectionOptions: Additional options for configuring the scene.
     */
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    /**
     Called as the scene is being released by the system.
     
     This occurs shortly after the scene enters the background, or when its session is discarded.
     Release any resources associated with this scene that can be re-created the next time the scene connects.
     The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
     
     - Parameter scene: The scene being disconnected.
     */
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    /**
     Called when the scene has moved from an inactive state to an active state.
     
     Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
     
     - Parameter scene: The scene that became active.
     */
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    /**
     Called when the scene will move from an active state to an inactive state.
     
     This may occur due to temporary interruptions (e.g., an incoming phone call).
     
     - Parameter scene: The scene that will resign active state.
     */
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    /**
     Called as the scene transitions from the background to the foreground.
     
     Use this method to undo the changes made on entering the background.
     
     - Parameter scene: The scene entering the foreground.
     */
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    /**
     Called as the scene transitions from the foreground to the background.
     
     Use this method to save data, release shared resources, and store enough scene-specific state information to restore the scene back to its current state.
     
     - Parameter scene: The scene entering the background.
     */
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
