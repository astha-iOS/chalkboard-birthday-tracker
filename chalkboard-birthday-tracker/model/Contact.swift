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
    var daysRemainingInNextBDay:Int?

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
            self.daysRemainingInNextBDay = calculateDaysReamingInNextBirthDay()
            
            
  }
    
    fileprivate func formateDOB() -> Date {
        let dateAndTime = self.dob!.components(separatedBy: "T")
        let date = dateAndTime[0]
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        return inputFormatter.date(from: date)!
    }
    
    fileprivate func daysRemaingInNextYearBirthday(_ bdayDate: Date, _ cal: Calendar, _ dayPassedSoFarInThisYear: Int) -> Int {
        let currentYear = Calendar.current.component(.year, from: bdayDate)
        
        var lastDayOfTheYear = DateComponents()
        lastDayOfTheYear.year = currentYear
        lastDayOfTheYear.month = 12
        lastDayOfTheYear.day = 31
        
        let lastDateOfThisYear = NSCalendar.current.date(from: lastDayOfTheYear)
        
        let daysInCurrentYear = cal.ordinality(of: .day, in: .year, for: lastDateOfThisYear!) ?? 0
        
        var nextYear = DateComponents()
        nextYear.year = 1
        
        let nextYearDate = cal.date(byAdding: nextYear, to: bdayDate)
        
        let daysFromNextYear = cal.ordinality(of: .day, in: .year, for: nextYearDate!) ?? 0
        let daysRemaingInCurrentYear = daysInCurrentYear-dayPassedSoFarInThisYear
        return daysFromNextYear+daysRemaingInCurrentYear
    }
    
    fileprivate func calculateDaysReamingInNextBirthDay() -> Int {
        let bdayDate = formateDOB()
        let today = Date()
        let calender = Calendar.current
        let dayPassedSoFarInThisYear = calender.ordinality(of: .day, in: .year, for: today) ?? 0
        let birthdaySinceBeginingOfThisYear = calender.ordinality(of: .day, in: .year, for: bdayDate) ?? 0

        let daysRemaining = birthdaySinceBeginingOfThisYear-dayPassedSoFarInThisYear
   
        if(daysRemaining<0){
            return daysRemaingInNextYearBirthday(bdayDate, calender, dayPassedSoFarInThisYear)
    }
        return daysRemaining
    }
    
 }
