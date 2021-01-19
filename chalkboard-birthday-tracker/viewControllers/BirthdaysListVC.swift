//
//  BirthdaysListVC.swift
//  chalkboard-birthday-tracker
//
//  Created by Astha yadav on 19/01/21.
//

import UIKit

class BirthdaysListVC: UIViewController, ServicesDelegate{
    
    @IBOutlet weak var table_BirthdayList: UITableView!
    let restClient = RestClient()
    var contacts : [Contact] = []
    var sortedContacts : [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        restClient.delegate = self
        restClient.getUsers(recordCount:20)
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
                
                self.sortedContacts = self.contacts.sorted(by: { $0.daysRemainingInNextBDay ?? 0 < $1.daysRemainingInNextBDay ?? 0})
                
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
        return self.sortedContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdaysListTableCell", for: indexPath) as! BirthdaysListTableCell
        
        cell.lbl_profile.layer.cornerRadius = cell.lbl_profile.frame.size.height/2
        cell.lbl_profile.clipsToBounds = true
        
        let contact = self.sortedContacts[indexPath.row]
        
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
                
                let contact = self.sortedContacts[indexPath.row]
                vc.strName = contact.fullName ?? ""
                vc.strAge = String(contact.age ?? 0)
                vc.strTitle = contact.imgTitle ?? ""
            }
        }
    }
        
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension UIView{
    func setCornerRadious(radious:CGFloat){
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
}
