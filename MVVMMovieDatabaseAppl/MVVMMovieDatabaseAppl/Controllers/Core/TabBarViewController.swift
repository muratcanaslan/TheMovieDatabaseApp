//
//  ViewController.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 11.03.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = MovieViewController()
        let vc2 = TvViewController()
        
        vc1.title = "Movie"
        vc2.title = "TV"
        
        vc1.navigationItem.largeTitleDisplayMode = .never
        vc2.navigationItem.largeTitleDisplayMode = .never
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        

        nav1.tabBarItem = UITabBarItem(title: "MOVIE", image: UIImage(systemName: "film"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "TV", image: UIImage(systemName: "tv"), tag: 1)
        
        nav1.navigationBar.barTintColor = UIColor.init(rgb: 0x03045e)
        nav1.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        nav1.navigationBar.barStyle = UIBarStyle.blackTranslucent
        nav2.navigationBar.barStyle = UIBarStyle.blackTranslucent

        nav1.navigationBar.tintColor = .yellow
        nav2.navigationBar.tintColor = .yellow
        nav2.navigationBar.barTintColor = UIColor.init(rgb: 0x03045e)
        nav2.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        tabBar.barTintColor = UIColor.init(rgb: 0x03045e)
        tabBar.tintColor = .white

        nav1.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = false        
        setViewControllers([nav1,nav2], animated: false)
    }
}

