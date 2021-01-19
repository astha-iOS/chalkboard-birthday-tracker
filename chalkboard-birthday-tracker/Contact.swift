//
//  Contact.swift
//  chalkboard-birthday-tracker
//
//  Created by Astha yadav on 19/01/21.
//

import Foundation

class Contact {
    var title : String?
    var firstName : String?
    var lastName: String?
    var fullName: String?
    var dob : String?
    var age: Int?
    var imgTitle: String?

        init?(dictDob:[String:Any],dictName:[String:Any]) {
            guard let title = dictName["title"],
                let firstName = dictName["first"],
                let lastName = dictName["last"],
                let dob = dictDob["date"],
                let age = dictDob["age"]
            else {
                return nil
            }
            
            self.title = title as? String ?? ""
            self.firstName = firstName as? String ?? ""
            self.lastName = lastName as? String ?? ""
            self.fullName = self.title! + " " + self.firstName! + " " + self.lastName!
            self.dob = dob as? String
            self.age = age as? Int
            self.imgTitle = String(self.firstName!.first!) + String(self.lastName!.first!)
            
            
  }
    
    fileprivate func formateDOB() -> Date {
        let dateAndTime = self.dob!.components(separatedBy: "T")
        let date = dateAndTime[0]
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        return inputFormatter.date(from: date)!
    }
    
   
 }
