//
//  Constants.swift
//  StorageCloud
//
//  Created by Naved  on 01/05/24.
//

import Foundation

struct Constants {
    static var shared = Constants()
    var mode = "mode"
    var isAuth = "isAuth"
}

struct UserDefaultValue{
    static var shared = UserDefaultValue()
    var getCurrentMode : String {
        return UserDefaults.standard.string(forKey: Constants.shared.mode) ?? "mode"
    }
    
    var getAuth : Bool{
        return UserDefaults.standard.bool(forKey:  Constants.shared.isAuth)
    }
    
    func setAuth(value : Bool) {
        UserDefaults.standard.setValue(value, forKey:  Constants.shared.isAuth)
    }
}
