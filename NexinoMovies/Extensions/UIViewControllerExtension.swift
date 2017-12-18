//
//  UIViewControllerExtension.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, text: String) {
        
        let alert: UIAlertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
