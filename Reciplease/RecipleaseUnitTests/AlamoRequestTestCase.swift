//
//  AlamoRequestTestCase.swift
//  RecipleaseUnitTests
//
//  Created by Fabrice Ortega on 30/12/2020.
//

import XCTest
import Alamofire
@testable import Reciplease

class AlamoRequestTestCase: XCTestCase {
    
    func testResponse() {
        
        let expectation = self.expectation(description: "Alamofire")
        
        var recipe: ResponseObject!
        
        
        AlamoRequest.alamoRequest.getRequest(ingredient: "Lemon", callback: {result in
            guard let result = result else {return}
            if let data = result.value {
                recipe = data
                
                let resultString = recipe.hits[0].recipe.label
                let expectedString = "Lemon Confit"
                
                XCTAssertEqual(resultString, expectedString)
                
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
