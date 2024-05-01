//
//  extension.swift
//  StorageCloud
//
//  Created by Naved  on 01/05/24.
//

import Foundation
import UIKit

// view message
extension UIViewController {
    func showAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
