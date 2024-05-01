//
//  LoginViewController.swift
//  StorageCloud
//
//  Created by Naved  on 13/02/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var numberTextfield: UITextField!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var verificationID = String()
    // MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        if otpTextField.isUserInteractionEnabled{
            signInMethod()
        }
        else{
            sendVerificationCode()
            }
    }
}

extension LoginViewController{
    
    func sendVerificationCode(){
        //        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        LoaderHelper.shared.startLoader(view)
        guard  let phoneNumber = numberTextfield.text , numberTextfield.text != "" else { return }
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription.debugDescription)
                    return
                }
                LoaderHelper.shared.stopLoader()
                self.verificationID = verificationID ?? ""
                self.otpTextField.isUserInteractionEnabled = true
                self.loginButton.titleLabel?.text = "Verify Otp"
            }
        
    }
    
    func signInMethod(){
        //        Test
        //        let phoneNumber = "+19999999999"
        //        let verificationCode = "123123"
        LoaderHelper.shared.startLoader(view)
        guard let verificationCode = otpTextField.text , verificationCode != "" else { return }
        guard  verificationCode != "" else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            else{
                self.makeTransitionToHome()
                self.otpTextField.isUserInteractionEnabled = false
                self.loginButton.titleLabel?.text = "Send Otp"
                UserDefaultValue.shared.setAuth(value: true)
                LoaderHelper.shared.stopLoader()
            }
        }
    }
    
    func makeTransitionToHome(){
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tabbar")
        if  let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as? SceneDelegate{
            sceneDelegate.window?.rootViewController =  rootVc
        }
    }
    
}

