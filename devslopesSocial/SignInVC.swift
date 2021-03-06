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
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID)
        {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
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
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil
            {
                print("UNABLE to authenticate with firebase")
            }
            else
            {
                print("SAUD: it's all fully authenticated with firebase")
                self.completeSignIn(id: (user?.uid)!, userData: credential.provider as! Dictionary<String,String>)      
                KeychainWrapper.standard.set((user?.uid)!, forKey: KEY_UID)
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
                    let userData = ["providers" : user?.providerID]
                    self.completeSignIn(id: (user?.uid)!,userData: userData as! Dictionary<String, String>)
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
                            print("Saud:  Successfully, user has been authenticated using the email method")
                            let userData = ["provider" : user?.providerID]
                            self.completeSignIn(id: (user?.uid)!,userData: userData as! Dictionary<String,String>)
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String,userData: Dictionary<String,String>)
    {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("SAUD: Keychain setup has been done")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }

}
