//
//  AlamoRequest.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 26/12/2020.
//

import Foundation
import Alamofire

class AlamoRequest {
    
    // Pattern singleton
    public static let alamoRequest = AlamoRequest()
    
    //API key and app ID
    let apiKey = "e9cd4953e3e8faa0efb57bd69fcd67af"
    let appID = "3b0ddcdf"
    
    // Set up a notification when card did swipe to the up
    static let notificationRecipeLoaded = Notification.Name("recipeLoaded")
    
    // To get the data from the request
    var recipe : ResponseObject! {
        didSet {
            DispatchQueue.main.async {
                print(self.recipe.hits[0].recipe.label!)
                NotificationCenter.default.post(name: AlamoRequest.notificationRecipeLoaded, object: nil, userInfo: nil)
            }
        }
    }
    
    // Public init for pattern singleton
    public init() {}
    
    
    func getRequest(ingredient: String) {
        
        let parameters = ["q":ingredient,"to":"100","app_id":appID,"app_key":apiKey]
        
        AF.request("https://api.edamam.com/search?", method: .get, parameters: parameters).responseDecodable(of: ResponseObject.self) { (response) in
            // Check if result has a value
            if let data = response.value {
//                print(data)
                self.recipe = data
            }
        }
    }
    
}
