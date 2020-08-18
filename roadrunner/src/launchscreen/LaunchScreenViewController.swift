//
//  LaunchScreenViewController.swift
//  roadrunner
//
//  Created by TED on 2020/07/25.
//  Copyright © 2020 roadrunner. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }

}
