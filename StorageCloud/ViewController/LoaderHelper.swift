//
//  oaderHelper.swift
//  StorageCloud
//
//  Created by Naved  on 30/04/24.
//


import Foundation
import UIKit
import MBProgressHUD
class LoaderHelper : NSObject {
    var progressHud = MBProgressHUD()
    static let shared = LoaderHelper()

    // MARK: - START LOADER
    func startLoader(_ view:UIView, backGrounColor: UIColor = .clear, isTextMsg : Bool = false) {

         if progressHud.superview != nil {
             progressHud.hide(animated: false)
         }

         if #available(iOS 9.0, *) {
             UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color =  .white
         }
         progressHud = MBProgressHUD.showAdded(to: view, animated: true)
         progressHud.bezelView.color = UIColor.blue.withAlphaComponent(0.8)
         progressHud.bezelView.style = .solidColor
         progressHud.bezelView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
         progressHud.backgroundView.color = (#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).withAlphaComponent(0))
         progressHud.label.text =  isTextMsg ? "Please Wait..." : ""
         progressHud.label.textColor = .white
         progressHud.show(animated: true)
        
     }
     //MARK: - STOP LOADER
     func stopLoader() {
         progressHud.hide(animated: true)
     }
}

