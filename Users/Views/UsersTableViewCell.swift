//
//  UsersTableViewCell.swift
//  Users
//
//  Created by Alley Pereira on 17/07/21.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    static let identifier = "UsersTableViewCell"

    // MARK: - Views
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()


    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(userImageView)

        self.contentView.subviews.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            userImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: userImageView.trailingAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).priority(.defaultLow)
        ])
    }

}

// MARK: - Extension Constraint
extension NSLayoutConstraint {
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
