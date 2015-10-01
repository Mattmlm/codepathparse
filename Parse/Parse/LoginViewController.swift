//
//  LoginViewController.swift
//  Codepath Parse
//
//  Created by admin on 9/30/15.
//  Copyright © 2015 mattmo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func signinButtonPressed(sender: AnyObject) {
       PFUser.logInWithUsernameInBackground(emailTextField.text!, password:passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
            } else {
                // The login failed. Check error to see why.
                self.throwErrorAlert("Sign In error")
            }
        }
    }
    
    @IBAction func signupButtonPressed(sender: AnyObject) {
        var user = PFUser()
        user.username = "codepathtesting1"
        user.password = passwordTextField.text!
        user.email = emailTextField.text!
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                self.throwErrorAlert("Sign Up error")
            } else {
                // Hooray! Let them use the app now.
            }
        }
    }
    
    func throwErrorAlert(error: String) {
        let alert: UIAlertController = UIAlertController(title: error, message: "There is an error", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            //
        }
        
        alert.addAction(defaultAction);
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
