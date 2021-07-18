//
//  UsersView.swift
//  Users
//
//  Created by Alley Pereira on 17/07/21.
//

import UIKit

class UsersView: UIView {

    var usersResult: RequestModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Views
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.identifier)
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        return table
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        self.addSubview(tableView)
        setupContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Contraints
    private func setupContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }


}

// MARK: - TableView
extension UsersView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersResult?.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath) as? UsersTableViewCell,
              let user = usersResult?.data[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = "\(user.first_name) \(user.last_name)"
        cell.emailLabel.text = user.email

        // MARK: - Request Image avatar
        let url = URL(string: user.avatar)! //criar URL com a string que esta armazenada em user.avatar
        // fazer a requisicao get pra link da variavel avatar
        URLSession.shared.dataTask(with: url) { data, _, error in // O retorno que vem na completion é o data (bytes da img)
            if error == nil, let data = data {
                DispatchQueue.main.async {
                    cell.userImageView.image = UIImage(data: data) // Criar uma uiimage com o data e atribuir uiimage criada ao imageview ao image da celula
                }
            }
        }.resume()


        return cell
    }

}
