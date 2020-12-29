//
//  SearchTestCase.swift
//  RecipleaseTests
//
//  Created by Fabrice Ortega on 29/12/2020.
//

import XCTest
@testable import Reciplease

class SearchTestCase: XCTestCase {
    // Test if ingredients append in the array
    func testGivenIngredientsArrayIsEmptyWhenAddingOneIngredientThenArrayShouldHaveOneElement() {
        Search.searchClass.ingredientList = []
        
        Search.searchClass.addIngredient(ingredient: "chicken")
        
        XCTAssert(Search.searchClass.ingredientList.count == 1)
    }
    
    // Test if ingredients removed from the array
    func testGivenIngredientsArrayIsOneElementWhenClearingTheArrayThenArrayShouldBeEmpty() {
        Search.searchClass.ingredientList = ["chicken"]
        
        Search.searchClass.clearIngredients()
        
        XCTAssert(Search.searchClass.ingredientList.count == 0)
    }
    
    // Test for "ingredientsForRequest"
    func testGivenIngredientsArrayHasThreeElementsThenIgredientsForRequestShouldBeWithGoodFormat() {
        Search.searchClass.ingredientList = ["chicken","tomato","mushrooms"]
        
        XCTAssert(Search.searchClass.ingredientListForResquest == "chicken/tomato/mushrooms")
    }
}
