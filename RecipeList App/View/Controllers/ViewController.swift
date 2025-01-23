//
//  ViewController.swift
//  RecipeList App
//
//  Created by Mac on 23/01/25.
//


import UIKit

class ViewController: UIViewController {
    var arrayImage = [RecipeElement]()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Recipes"
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
        tableView.frame = view.bounds
        view.addSubview(tableView)
        loadRecipesFromFile()

    }
    
    func loadRecipesFromFile() -> [RecipeElement]? {
        guard let url = Bundle.main.url(forResource: "Directions", withExtension: "json") else {
            print("File not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let recipes = try JSONDecoder().decode([RecipeElement].self, from: data)
            print("recipes decoding JSON: \(recipes)")
            self.arrayImage = recipes
            print("arrayImage recipesRecipe: \(arrayImage.count)")
            return recipes
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayImage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        let recipe = arrayImage[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedRecipe = arrayImage[indexPath.row]
            let detailsVC = DetailsViewController()
            detailsVC.recipe = selectedRecipe
            print("selectedRecipe \(selectedRecipe.image)")
            navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

