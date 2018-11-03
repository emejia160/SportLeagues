//
//  BaseViewController.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
     var progress: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showProgress(message: String, style: LoadingStyle, presentationContext: PresentationContext) {
        progress = LoadingView.show(inView: view, style: style, presentationContext: presentationContext)
        progress!.titleLabel.text = message
    }
    
    func showAlert(title: String, message: String) {
        progress?.hide(animated: true)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Aceptar", style: .default)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
}
