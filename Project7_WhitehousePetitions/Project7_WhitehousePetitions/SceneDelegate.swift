//
//  SceneDelegate.swift
//  Project7_WhitehousePetitions
//
//  Created by Effrafax Bulwer on 8/3/21.
//  Copyright © 2021 Effrafax Bulwer. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Для корректного отображения, нужно сначала отдельно создать window, а потом уже присвоить его переменной класса
        let window = UIWindow(windowScene: windowScene)
        
        // Программно создаем Контроллеры
        let firstVC = TableViewController()
        let secondVC = TableViewController()
        let tabBarController = UITabBarController()
        
        // Устанавливаем иконки в tabBar'e
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        // Создаем UINavigationController и устанавливаем его root
        let firstNavVC = UINavigationController(rootViewController: firstVC)
        let secondNavVC = UINavigationController(rootViewController: secondVC)
        
        // Устанавливаем VC для tabBar'a
        tabBarController.setViewControllers([firstNavVC], animated: true)
        tabBarController.viewControllers?.append(secondNavVC)
        
        // Обязательно назначаем rootVC для window
        window.rootViewController = tabBarController
        
        // Показываем окно и делаем кго ключевым
        window.makeKeyAndVisible()
        self.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

