import UIKit

class FancyButton: UIButton
{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius  = 5.0
        layer.shadowOffset  = CGSize(width: 1, height: 1)
        layer.cornerRadius  = 5
    }
    
}
