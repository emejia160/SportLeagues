//
//  SplashViewController.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 4/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation

import UIKit

class SplashViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "teamsSegue", sender: nil)
        }
    }
}

