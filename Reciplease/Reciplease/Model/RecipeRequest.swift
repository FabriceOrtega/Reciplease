//
//  RecipeRequest.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 22/12/2020.
//

import Foundation

struct RecipeRequest {
    // create the request body
    var requestBody = "q=chicken"
    
    //API key and app ID
    let apiKey = "e9cd4953e3e8faa0efb57bd69fcd67af"
    let appID = "3b0ddcdf"
    
    var url = URL(string: "https://api.edamam.com/search")
    
    var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    mutating func getRequest(ingredient:String, completion: @escaping(Result<ResponseObject, RecipeRequestError>) -> Void) {
        // Updtate the body according user's data
        requestBody = "q=\(ingredient)"
        
        // Include the api key in the request
        url = URL(string: "https://api.edamam.com/search?\(requestBody)&to=100&app_id=\(appID)&app_key=\(apiKey)")
        
        // Create the task
        let dataTask = session.dataTask(with: url!) {data, response, error in
            // check if data is available
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
//            // Print the data
//            if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
//                            print("Response \(stringResponse)")
//                        }
            
            // If data available, convert it thru the decoder
            do {
                let decoder = JSONDecoder()
                let recipeResponse = try decoder.decode(ResponseObject.self, from: jsonData)
//                print("test: \(recipeResponse)")
                
                completion(.success(recipeResponse))
                
                // If not ptossible to decode
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}

// Enumeration in order to be get more precise errprs
enum RecipeRequestError: Error {
    case noDataAvailable
    case canNotProcessData
}
