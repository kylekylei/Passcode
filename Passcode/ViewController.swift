//
//  ViewController.swift
//  Passcode
//
//  Created by Kyle Lei on 2021/11/24.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passowordTextField: UITextField!
    @IBOutlet weak var passworldRuleLabel: UILabel!
    @IBOutlet var eyeButton: UIButton!        

    var passwordDescripion = Password.rule
    

    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.shadowOffset = CGSize(width: 0, height: 20)
            signUpButton.layer.shadowRadius = 20
            signUpButton.layer.shadowColor = UIColor.blue.cgColor
            signUpButton.layer.shadowOpacity = 0.2
        }
    }
        
    func updateUI() {
        passworldRuleLabel.text = passwordDescripion.description
        passworldRuleLabel.textColor = passwordDescripion.textColor
        
    }
    
    func alertController(passwordStatus title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(alertaction)
        present(alertController, animated: true, completion: nil)
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        userNameTextField.textContentType = .username
        passowordTextField.isSecureTextEntry = false
        passowordTextField.textContentType = .oneTimeCode
        updateUI()
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        let usernameText = userNameTextField.text!
        let passwordText = passowordTextField.text!
        
        guard usernameText.isEmpty == false else {
            alertController(passwordStatus: InputStatus.usernameEmpty.message.0, InputStatus.usernameEmpty.message.1)
            return
        }
        guard passwordText.isEmpty == false else {
            alertController(passwordStatus: InputStatus.passwordEmpty.message.0, InputStatus.passwordEmpty.message.1)
            return
        }

        passwordDescripion = checkPassword(username: usernameText, password: passwordText)
        updateUI()
        if passwordDescripion == Password.createSuccessful {
            alertController(passwordStatus: InputStatus.pass.message.0, InputStatus.pass.message.1)
        }
    }
    
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        passowordTextField.isSecureTextEntry.toggle()
        var image = ""
        switch passowordTextField.isSecureTextEntry {
        case true: image = "eye.slash"
        case false: image = "eye"
        }
        
        var configure = UIButton.Configuration.plain()
        configure.background.image = UIImage(systemName: image)
        configure.background.imageContentMode = .scaleAspectFit
        eyeButton.configuration = configure
        print(image, passowordTextField.isSecureTextEntry)
    }
    
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
