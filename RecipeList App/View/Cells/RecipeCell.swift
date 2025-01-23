//
//  RecipeCell.swift
//  RecipeList App
//
//  Created by Mac on 23/01/25.
//

import UIKit

class RecipeCell: UITableViewCell {

    let recipeImageView = UIImageView()
    let nameLabel = UILabel()
    let cuisineLabel = UILabel()
    let heartButton = UIButton()
    var coloricon:Bool = false

    var favoriteAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 8

        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        cuisineLabel.font = UIFont.systemFont(ofSize: 14)
        cuisineLabel.textColor = .gray

        heartButton.setTitle("♥︎", for: .normal)
        heartButton.setTitleColor(.white, for: .normal)
        heartButton.setTitleColor(.red, for: .selected)
        heartButton.layer.cornerRadius = 20
        heartButton.layer.borderWidth = 1
        heartButton.layer.borderColor = UIColor.red.cgColor
        heartButton.clipsToBounds = true
        heartButton.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [recipeImageView, nameLabel, cuisineLabel, heartButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            recipeImageView.widthAnchor.constraint(equalToConstant: 80),
            recipeImageView.heightAnchor.constraint(equalToConstant: 80),
            heartButton.widthAnchor.constraint(equalToConstant: 40),
            heartButton.heightAnchor.constraint(equalToConstant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure(with recipe: RecipeElement) {
        if let url = URL(string: recipe.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.recipeImageView.image = image
                    }
                }
            }
        }
        nameLabel.text = recipe.name
        cuisineLabel.text = recipe.cuisine
        heartButton.isSelected = coloricon
        heartButton.backgroundColor = coloricon ? .white : .red
    }

    @objc func heartTapped() {
        coloricon = true
        heartButton.isSelected.toggle()
        heartButton.backgroundColor = heartButton.isSelected ? .white : .red
        favoriteAction?()
    }
}
