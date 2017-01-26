import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    @IBAction func signOut(_ sender: Any)
    {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return tableView.dequeueReusableCell(withIdentifier: "CellVC") as! CellVC
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
}
