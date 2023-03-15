//
//  LoginViewController.swift
//  News
//
//  Created by avinash on 15/03/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var btn: UIButton!
    @IBOutlet var txtfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnCheck(_ sender: Any) {
        let validLogin = isValidEmail(testStr: txtfield.text ?? "")
        if validLogin {
            print("User entered valid input")
           // nextScreen()
            performSegue(withIdentifier: "login", sender: btn)
           

        } else {
            print("Invalid email address")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.modalPresentationStyle = .fullScreen
            
        }
    }
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let range = testStr.range(of: emailRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    
    func nextScreen(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
            navigationController?.pushViewController(vc!, animated: true)
    }
}
