//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 27/12/2020.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    // Get from the cell the user selected
    var recipe: Recipe!
    
    // Recipe name label
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    // Outlet of text view for ingredients text view
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    // Image outlet
    @IBOutlet weak var recipeImageOutlet: UIImageView!
    
    // Time image outlets
    @IBOutlet weak var timeImageOutlet: UIView!
    
    // Time label
    @IBOutlet weak var timeLabel: UILabel!
    
    // Star button (favorite) outlet
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Attribute all outlets
        attributeOutlets()
        
        // Back button
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    // Get direction button
    @IBAction func getDirectionsButton(_ sender: Any) {
        // Send to website
        if let urlLink = recipe.url {
            guard let url = URL(string: urlLink) else { return }
            UIApplication.shared.open(url)
        } else {
            alert(title: "Error", message: "Link for recipe missing")
        }
        
    }
    
    // Add to favorite button
    @IBAction func addToFavoriteButton(_ sender: Any) {
        // Change color of button
        changeFavoriteButtonColor()
        
        // Core Data method
        saveOrRemoveRecipe()
        
        // Check if favorite or not
        checkIfAlreadyInFavorite()
    }
    
    // Method to attribute all outlets
    private func attributeOutlets(){
        // Recipe name label
        recipeNameLabel.text = recipe.label
        
        // Attribute image
        attributeImage()
        
        // Attribute ingredients
        attributeIngredients()
        
        // Round corners and draw border of time image
        roundCornersTimeImage()
        
        // Attribute the time
        timeLabel.text = attributeTime(time: recipe.totalTime)
        
        // if favorite, put the button in green
        checkFavorite()
        
    }
    
    // Method to change color of teh star
    private func changeFavoriteButtonColor(){
        if favoriteButtonOutlet.tintColor == #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1) {
            favoriteButtonOutlet.tintColor = #colorLiteral(red: 0.2653724849, green: 0.5822041631, blue: 0.3644598722, alpha: 1)
        } else if favoriteButtonOutlet.tintColor == #colorLiteral(red: 0.2653724849, green: 0.5822041631, blue: 0.3644598722, alpha: 1) {
            favoriteButtonOutlet.tintColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
        }
    }
    
    // Method to check if already as favorite or not
    private func checkIfAlreadyInFavorite(){
        if favoriteButtonOutlet.tintColor == #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1) {
            // Remove from the favorite array
            if let index = Favorites.favorites.favoriteRecipesArray.firstIndex(where: { $0.label == recipe.label }) {
                Favorites.favorites.removeFromFavorites(index: index)
            }
        } else if favoriteButtonOutlet.tintColor == #colorLiteral(red: 0.2653724849, green: 0.5822041631, blue: 0.3644598722, alpha: 1) {
            // Append in favorite array
            Favorites.favorites.addToFavorite(recipe: recipe)
        }
    }
    
    // Method to save/remove recipe from database
    private func saveOrRemoveRecipe(){
        if favoriteButtonOutlet.tintColor == #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1) {
            // Remove from database
            RecipeSaveManagement.recipeSaveManagement.removeRecipe(recipeToRemove: recipe)

        } else if favoriteButtonOutlet.tintColor == #colorLiteral(red: 0.2653724849, green: 0.5822041631, blue: 0.3644598722, alpha: 1) {
            // Save in database
            RecipeSaveManagement.recipeSaveManagement.saveRecipe(recipeToSave: recipe)
        }
    }
    
    
    // Method to attribute the image
    private func attributeImage() {
        // attribute the image (calling a method from below extension)
        let link = recipe.image ?? "https://www.edamam.com/web-img/2c0/2c0ac2c82407335d6141e699a7442164.jpg"
        recipeImageOutlet.downloaded(from: link)
        recipeImageOutlet.contentMode = .scaleAspectFill
        // Attribute gradient for the images
        recipeImageOutlet.subviews.forEach({ $0.removeFromSuperview() })
        let view = gradient(viewFrame: recipeImageOutlet)
        recipeImageOutlet.addSubview(view)
        recipeImageOutlet.bringSubviewToFront(view)
    }
    
    // Method to attribute the ingredients
    private func attributeIngredients(){
        if recipe.ingredientLines != nil {
            // Create a string from the array
            let ingredientsList: String = "- " + (recipe.ingredientLines?.joined(separator:"\n- "))!
            // Attribute the string to the text view
            ingredientsTextView.text = ingredientsList
        } else {
            ingredientsTextView.text = ""
        }
    }
    
    // Method to round the corners and draw the borders of the time image
    private func roundCornersTimeImage(){
        // Round the corners of the time view
        timeImageOutlet.layer.cornerRadius = 5
        timeImageOutlet.layer.borderWidth = 1
        timeImageOutlet.layer.borderColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
    }
    
    // Method to check if recipe is in favorite
    private func checkFavorite() {
        // Search for this recipe in list favorite
        if (Favorites.favorites.favoriteRecipesArray.firstIndex(where: { $0.label == recipe.label }) != nil) {
            favoriteButtonOutlet.tintColor = #colorLiteral(red: 0.2653724849, green: 0.5822041631, blue: 0.3644598722, alpha: 1)
        }
    }

}
