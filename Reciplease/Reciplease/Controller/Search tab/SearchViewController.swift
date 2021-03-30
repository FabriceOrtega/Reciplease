//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 26/12/2020.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    // Outlet of text view, where the ingredients will appear
    @IBOutlet weak var textViewOutlet: UITextView!
    
    // Outlet of text field to enter new ingredient
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    // Search view outlet
    @IBOutlet weak var searchViewOutlet: UIView!
    
    //Button outlets
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var clearButtonOutlet: UIButton!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    
    // Corner radius for all buttons
    var smallCornerRadius: CGFloat = 12
    var cornerRadius: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Set the text fields delegates
        self.textFieldOutlet.delegate = self
        
        // Set textfield placeholder and border color
        textFieldOutlet.attributedPlaceholder = NSAttributedString(string: "Lemon, Cheese, Sausages...",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textFieldOutlet.layer.borderWidth = 1.0
        textFieldOutlet.layer.borderColor = UIColor.gray.cgColor
        
        // Corner radius
        textFieldOutlet.layer.cornerRadius = smallCornerRadius
        addButtonOutlet.layer.cornerRadius = smallCornerRadius
        clearButtonOutlet.layer.cornerRadius = smallCornerRadius
        searchButtonOutlet.layer.cornerRadius = cornerRadius
        searchViewOutlet.layer.cornerRadius = cornerRadius
        
        // Load data from database
        Favorites.favorites.fillFavoriteRecipeArray()
    }
    
    // Dismiss the keyboard (tap on the view)
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Dismiss the keyboard (Done)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textFieldOutlet.text != "" {
            // Append the array of ingredients
            Search.searchClass.addIngredient(ingredient: textFieldOutlet.text!)
            updateTextView()
            textFieldOutlet.text = ""
        }
        return false
    }
    
    @IBAction func searchRecipeButton(_ sender: Any) {
        // Call the request thru the alamofire request
        if Search.searchClass.ingredientList.count > 0 {
            // Append the array of ingredients
            AlamoRequest.alamoRequest.getRequest(ingredient: Search.searchClass.ingredientListForResquest, callback: {result in guard let result = result else {return}
                if let data = result.value {
                    AlamoRequest.alamoRequest.recipe = data
                }
            })
            // Go to the tableView scene
            performSegue(withIdentifier: "toRecipeList", sender: nil)
        } else {
            //Alert
            alert(title: "Error", message: "Please enter an ingredient to add")
        }
        
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        addIngredient()
    }
    
    // Method to add an ingredient to the list
    func addIngredient(){
        if textFieldOutlet.text != "" {
            // Append the array of ingredients
            Search.searchClass.addIngredient(ingredient: textFieldOutlet.text!)
            updateTextView()
            textFieldOutlet.text = ""
        } else {
            //Alert
            alert(title: "Error", message: "Please enter an ingredient to add")
        }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        Search.searchClass.clearIngredients()
        updateTextView()
    }
    
    // Method to update the textView
    func updateTextView() {
        var ingredientText = ""
        if Search.searchClass.ingredientList.count > 0 {
            for i in 0...(Search.searchClass.ingredientList.count-1) {
                ingredientText += "- " + Search.searchClass.ingredientList[i] + "\n"
            }
        } else {
            ingredientText = ""
        }
        textViewOutlet.text = ingredientText
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeList" {
            _ = segue.destination as! RecipeTableViewController
        }
    }
    
    
}

// Extension for the alert method
extension UIViewController {
    // Method to call an alert
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

