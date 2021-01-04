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
    let apiKey = ""
    let appID = ""
    
    // Set a notification when the recipe are loaded
    static let notificationRecipeLoaded = Notification.Name("recipeLoaded")
    
    // To get the data from the request
    var recipe : ResponseObject? {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: AlamoRequest.notificationRecipeLoaded, object: nil, userInfo: nil)
            }
        }
    }
    
    // Public init for pattern singleton
    public init() {}
    
    
    func getRequest(ingredient: String, callback: @escaping(_ result: DataResponse<ResponseObject, AFError>?) -> Void) {
        
        let parameters = ["q":ingredient,"to":"100","app_id":appID,"app_key":apiKey]
        
        AF.request("https://api.edamam.com/search?", method: .get, parameters: parameters).responseDecodable(of: ResponseObject.self) { (response) in
            callback(response)
        }
    }
    
}
