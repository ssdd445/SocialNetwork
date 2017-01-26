//
//  CellVC.swift
//  devslopesSocial
//
//  Created by Waqar Air on 1/25/17.
//  Copyright © 2017 Saud. All rights reserved.
//

import UIKit

class CellVC: UITableViewCell {
    
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var postImage:UIImageView!
    @IBOutlet weak var caption:UITextView!
    @IBOutlet weak var likesLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
