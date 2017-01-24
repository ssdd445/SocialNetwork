import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func signOut(_ sender: Any)
    {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}
