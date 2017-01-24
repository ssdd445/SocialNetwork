import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController
{

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any)
    {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil
            {
                print(error as! String + "NOT FACEBOOK")
            }
            else if result?.isCancelled == true
            {
                print("SAUD: User didn't you to access their email address")
            }
            else
            {
                print("Yout got in:SAUD")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.fireBaseAuth(credential)
            }
        }
    }
    
    func fireBaseAuth(_ credential: FIRAuthCredential)
    {
        FIRAuth.auth()?.signIn(with: credential, completion: { (result, error) in
            if error != nil
            {
                print("UNABLE to authentice with firebase")
            }
            else
            {
                print("SAUD: it's all fully authenticated with firebase")
                let customKeychainWrapperInstance:KeychainWrapper!
                customKeychainWrapperInstance.set(<#T##value: Bool##Bool#>, forKey: <#T##String#>)
                customKeychainWrapperInstance.string(forKey: "myKey")
            }
        })
    }
    
    @IBAction func emailSignInButton(_ sender: UIButton)
    {
        if let email = emailField.text, let password = passwordField.text
        {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil
                {
                    print("Email has been given acccess")
                }
                else
                {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil
                        {
                            print("Saud: this is an error")
                        }
                        else
                        {
                            print("Saud: Successfully, user has been authenticated ussingthe email method")
                        }
                    })
                }
            })
        }
    }
}
