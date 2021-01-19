//
//  BirthdaysListVC.swift
//  chalkboard-birthday-tracker
//
//  Created by Astha yadav on 19/01/21.
//

import UIKit

class BirthdaysListVC: UIViewController {
    
    @IBOutlet weak var table_BirthdayList: UITableView!
    let apiObj = RestApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        apiObj.getUsersApi()
    }
    

    

}
//MARK:- UITableView Delegate Datasource
extension BirthdaysListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdaysListTableCell", for: indexPath) as! BirthdaysListTableCell
        
        cell.lbl_profile.layer.cornerRadius = cell.lbl_profile.frame.size.height/2
        cell.lbl_profile.clipsToBounds = true
        
    

        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
            if let navigator = navigationController {
                navigator.pushViewController(vc, animated: true)
            }
        }
    }
        
}
