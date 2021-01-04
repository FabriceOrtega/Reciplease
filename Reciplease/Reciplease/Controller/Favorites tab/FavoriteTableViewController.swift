//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 28/12/2020.
//

import UIKit

class FavoriteTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table view outlet
    @IBOutlet var favoriteTableView: UITableView!
    
    // To pass data to the detailled view
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Relaod data from table view
        favoriteTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Relaod data from table view
        favoriteTableView.reloadData()
    }

    // MARK: - Table view data source


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Favorites.favorites.favoriteRecipesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell
        
        // Attribue the recipe name
        if let responseCount = Favorites.favorites.favoriteRecipesArray[indexPath.row].label {
            cell?.recipeNameLabel.text = responseCount
        } else {
            cell?.recipeNameLabel.text = ""
        }
        
        // Attribute the ingredients
        if Favorites.favorites.favoriteRecipesArray[indexPath.row].ingredientLines != nil {
            let ingredientsText = Favorites.favorites.favoriteRecipesArray[indexPath.row].ingredientLines!.joined(separator:", ")
            cell?.ingredientsLabel.text = ingredientsText
        } else {
            cell?.ingredientsLabel.text = ""
        }
        
        // attribute the image (calling a method from below extension)
        let link = Favorites.favorites.favoriteRecipesArray[indexPath.row].image ?? "https://www.edamam.com/web-img/2c0/2c0ac2c82407335d6141e699a7442164.jpg"
        cell?.backgroundImageOutlet?.downloaded(from: link)
        cell?.backgroundImageOutlet?.contentMode = .scaleAspectFill
        
        // Attribute gradient for the images
        cell?.backgroundImageOutlet?.subviews.forEach({ $0.removeFromSuperview() })
        let view = gradient(viewFrame: (cell?.backgroundImageOutlet)!)
        cell?.backgroundImageOutlet?.addSubview(view)
        cell?.backgroundImageOutlet?.bringSubviewToFront(view)
        
        // Round the corners of the time view
        cell?.timeViewOutlet.layer.cornerRadius = 5
        cell?.timeViewOutlet.layer.borderWidth = 1
        cell?.timeViewOutlet.layer.borderColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)

        // Attribute the timing
        cell?.timeLabel.text = attributeTime(time: Favorites.favorites.favoriteRecipesArray[indexPath.row].totalTime)

        
        return cell!
    }
    
    // MARK: Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Attribute recipe object from table view to recipe parameter
        recipe = Favorites.favorites.favoriteRecipesArray[indexPath.row]
        // Perform the segueway
        performSegue(withIdentifier: "favoriteToDetail", sender: nil)
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteToDetail" {
            let detailVC = segue.destination as! RecipeDetailsViewController
            detailVC.recipe = recipe
        }
    }

}
