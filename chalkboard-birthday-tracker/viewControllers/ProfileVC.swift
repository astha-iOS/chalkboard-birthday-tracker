//
//  ProfileVC.swift
//  chalkboard-birthday-tracker
//
//  Created by Astha yadav on 19/01/21.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var btn_goBack: UIButton!
    
    @IBOutlet weak var lbl_yearOld: UILabel!
    @IBOutlet weak var lbl_Profile: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    
    var strName = String()
    var strTitle = String()
    var strAge = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        btn_goBack.setCornerRadious(radious: 5.0)
        lbl_Profile.setCornerRadious(radious: lbl_Profile.frame.size.height/2)
        
        lbl_Profile.text = strTitle
        lbl_Name.text = strName
        lbl_yearOld.text = strAge + " YEARS OLD"
        
    }

    @IBAction func goBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  
}



