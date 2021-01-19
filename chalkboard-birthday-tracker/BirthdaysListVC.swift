//
//  BirthdaysListVC.swift
//  chalkboard-birthday-tracker
//
//  Created by Astha yadav on 19/01/21.
//

import UIKit

class BirthdaysListVC: UIViewController, ServicesDelegate{
    
    @IBOutlet weak var table_BirthdayList: UITableView!
    let apiObj = RestApi()
    var contacts : [Contact] = []
    var sortedContacts : [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        apiObj.delegate = self
        apiObj.getUsersApi()
    }
    

    //MARK: - Success
    func didSuccess(result: Any, withID: String) {
        
        if withID == "contact_list"{
            let dict:[String:Any] = result as! [String : Any]
                let users = dict["results"] as! NSArray
                for user in users {
                    if let userDictionary = user as? NSDictionary {
                        
                        let name = userDictionary["name"] as! [String : Any]
                        let dob = userDictionary["dob"] as! [String : Any]
                        
                        if let contact = Contact(dictDob: dob ,dictName: name ){
                            self.contacts.append(contact)
                        }
                    }
                }
               
                
                DispatchQueue.main.async {
                    self.table_BirthdayList.reloadData()
                }
        }
    }
    
    //MARK: - Error
    func didError(result: Any, withID: String) {
        if withID == "contact_list"{
            print("error")
        }
    }

}
//MARK:- UITableView Delegate Datasource
extension BirthdaysListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdaysListTableCell", for: indexPath) as! BirthdaysListTableCell
        
        cell.lbl_profile.setCornerRadious(radious: cell.lbl_profile.frame.size.height/2)

        let contact = self.contacts[indexPath.row]
        
        cell.lbl_name.text = contact.fullName
        
        let dob = contact.dob ?? ""
        let strDob = dob.components(separatedBy: "T")[0]
        cell.lbl_birthday.text = formateDate(strDob)
        cell.lbl_profile.text = contact.imgTitle
    

        return cell
    }
    
    fileprivate func formateDate(_ dob:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = dateFormatter.date(from: dob)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: showDate!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
            if let navigator = navigationController {
                navigator.pushViewController(vc, animated: true)
            }
        }
    }
        
}

extension UIView{
    func setCornerRadious(radious:CGFloat){
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
}
