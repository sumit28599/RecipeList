//
//  DetailsViewController.swift
//  RecipeList App
//
//  Created by Mac on 23/01/25.
//


import UIKit

class DetailsViewController: UIViewController {
    var recipe: RecipeElement?

    private let recipeImageView = UIImageView()
    private let recipeNameLabel = UILabel()
    private let ingredientsLabel = UILabel()
    private let instructionsTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        displayRecipeDetails()
    }

    private func setupUI() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsTextView.translatesAutoresizingMaskIntoConstraints = false

        recipeNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        recipeNameLabel.numberOfLines = 0
        ingredientsLabel.numberOfLines = 0
        instructionsTextView.isEditable = false

        view.addSubview(recipeImageView)
        view.addSubview(recipeNameLabel)
        view.addSubview(ingredientsLabel)
        view.addSubview(instructionsTextView)

        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            recipeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            recipeImageView.widthAnchor.constraint(equalToConstant: view.frame.width - 20),

            recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 16),
            recipeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recipeNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            ingredientsLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 16),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            instructionsTextView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 16),
            instructionsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            instructionsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }

    private func displayRecipeDetails() {
        guard let recipe = recipe else { return }
            if let url = URL(string: recipe.image) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.recipeImageView.image = image
                        }
                    }
                }
            }
        recipeNameLabel.text = recipe.name
        ingredientsLabel.text = "Ingredients:\n" + recipe.ingredients.joined(separator: ", ")
        instructionsTextView.text = "Instructions:\n" + recipe.instructions.joined(separator: "\n")
    }
}

