//
//  RestApi.swift
//  chalkboard-birthday-tracker
//
//  Created by Astha yadav on 19/01/21.
//

import UIKit


let API_URL = "https://randomuser.me/api/?results=10&seed=chalkboard&inc=name,dob"


class RestApi: NSObject {
    
   
   //MARK:- getFriendsInfoApi
   func getUsersApi(){
       
       let request : NSMutableURLRequest = NSMutableURLRequest()
       request.url = NSURL(string: API_URL) as URL?
       request.httpMethod = "GET"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
       let session = URLSession.shared
       let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
           
           do {
               let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>

               print(json)

           
           } catch {
            print(error.localizedDescription)
           }
       })

       task.resume()
   }

}
