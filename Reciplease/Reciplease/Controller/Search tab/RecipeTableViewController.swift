//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 25/12/2020.
//

import UIKit

class RecipeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // table view outlet
    @IBOutlet var recipeTableVew: UITableView!
    
    // To pass data to the detailled view
    var recipe: Recipe!
    
//    // Instance of class recipeRequest
//    var recipeRequest = RecipeRequest(session: URLSession(configuration: .default))
//
//    // To get the data from the request
//    var recipe : ResponseObject! {
//        didSet {
//            DispatchQueue.main.async {
//                self.recipeTableVewOutlet.reloadData()
//                print("test")
//                //print(self.recipe.hits)
//                print(self.recipe.q)
//                print(self.recipe.count)
//                print(self.recipe.hits.count)
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Observe alamo request
        NotificationCenter.default.addObserver(self, selector: #selector(recipeLoaded(notification:)), name: AlamoRequest.notificationRecipeLoaded, object: nil)
        
        // Back button
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipeTableVew.reloadData()
    }
    
    // Method executed when the card swiped to the up
    @objc func recipeLoaded(notification:Notification) {
        recipeTableVew.reloadData()
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let responseCount = AlamoRequest.alamoRequest.recipe?.hits.count {
            return responseCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe", for: indexPath) as? RecipeTableViewCell
        
        // Attribue the recipe name
        if let responseCount = AlamoRequest.alamoRequest.recipe?.hits[indexPath.row].recipe.label {
            cell?.recipeName.text = responseCount
        } else {
            cell?.recipeName.text = ""
        }
        
        // Attribute the ingredients
        if AlamoRequest.alamoRequest.recipe?.hits[indexPath.row].recipe.ingredientLines != nil {
            let ingredientsText = AlamoRequest.alamoRequest.recipe?.hits[indexPath.row].recipe.ingredientLines!.joined(separator:", ")
            cell?.ingredientsLabel.text = ingredientsText
        } else {
            cell?.ingredientsLabel.text = ""
        }
        
        // attribute the image (calling a method from below extension)
        let link = AlamoRequest.alamoRequest.recipe?.hits[indexPath.row].recipe.image ?? "https://www.edamam.com/web-img/2c0/2c0ac2c82407335d6141e699a7442164.jpg"
        cell?.backgroundImage?.downloaded(from: link)
        cell?.backgroundImage?.contentMode = .scaleAspectFill
        
        // Attribute gradient for the images
        cell?.backgroundImage?.subviews.forEach({ $0.removeFromSuperview() })
        let view = gradient(viewFrame: (cell?.backgroundImage)!)
        cell?.backgroundImage?.addSubview(view)
        cell?.backgroundImage?.bringSubviewToFront(view)
        
        // Round the corners of the time view
        cell?.timeView.layer.cornerRadius = 5
        cell?.timeView.layer.borderWidth = 1
        cell?.timeView.layer.borderColor = #colorLiteral(red: 0.9386852384, green: 0.905385077, blue: 0.8662842512, alpha: 1)
        
        // Attribute the timing
        cell?.timeLabel.text = attributeTime(time: AlamoRequest.alamoRequest.recipe?.hits[indexPath.row].recipe.totalTime)
        
        return cell!
    }
    
    // MARK: Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Attribute recipe object from table view to recipe parameter
        recipe = AlamoRequest.alamoRequest.recipe?.hits[indexPath.row].recipe
        // Perform the segueway
        performSegue(withIdentifier: "toRecipeDetails", sender: nil)
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeDetails" {
            let detailVC = segue.destination as! RecipeDetailsViewController
            detailVC.recipe = recipe
        }
    }
    
    
//    func callAPI(ingredient: String){
//        recipeRequest.getRequest(ingredient: ingredient) {[weak self] result in
//            // Switch for succes or failure
//            switch result {
//            case .failure(let error):
//                print(error)
//                //self?.catchError = error
//            case .success(let recipe):
//                // if success, attribute the data
//                self?.recipe = recipe
////                print(recipe)
//            }
//        }
//    }


}

// Extension to be able download the image from the url contained in the API
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIViewController {
    // Method to draw the gradient on a view
    func gradient(viewFrame: UIImageView) -> UIView {
        let view = UIView(frame: (viewFrame.frame))
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        return view
    }
    
    // Method to attribute the timing
    func attributeTime(time: Double?) -> String {
        // Initiliaze a string value
        var timeText = ""
        
        // Check if time is not nil using optional binding
        if let recipeTime = time {
            // if time is 0
            if recipeTime == 0 {
                timeText = "?"
            } else if recipeTime < 60 {
                // If time is less than 1h
                timeText = String(Int(recipeTime)) + "min"
            } else {
                // If time is more than 1h
                let hours = recipeTime / 60
                let roundedHours: Int = Int(hours.rounded(.down))
                let minutes: Int = Int(recipeTime - Double(roundedHours * 60))
                if minutes < 10 {
                    timeText = String(roundedHours) + "h0" + String(minutes)
                } else {
                    timeText = String(roundedHours) + "h" + String(minutes)
                }
            }
        } else {
            // If time is nill
            timeText = "?"
        }
        return timeText
    }
    
}
