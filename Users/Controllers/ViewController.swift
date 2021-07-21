//
//  ViewController.swift
//  Users
//
//  Created by Alley Pereira on 16/07/21.
//

import UIKit

class ViewController: UIViewController, PaginationUserViewDelegate {

    let serviceManager = ServiceManager()

    // MARK: - TableView
    lazy var userView: UsersView = UsersView(frame: UIScreen.main.bounds)


    // MARK: - ViewController Lifecycle

    override func loadView() {
        super.loadView()
        self.view = userView
        userView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Users"
        fetchRequest()

    }

    // MARK: - Request
    func fetchRequest(page: Int = 1) {

        let urlRequest = URLRequest(url: serviceManager.getUsers(page: page))

        serviceManager.request(urlRequest, decodeType: RequestModel.self) { result in
            switch result {
            case .success(let model):
                //                model?.data.forEach({ user in
                //                    print("\n\(user.id)")
                //                    print(user.email)
                //                    print(user.first_name)
                //                    print(user.last_name)
                //                    print(user.avatar)
                //                })

                guard let model = model else { return }

                if let usersResult = self.userView.usersResult {
                    print("👺",model.page)

                    guard !model.data.isEmpty else { return } // caso nao tenha mais nada a ser paginado

                    let newModel = RequestModel(
                        page: model.page,
                        data: usersResult.data + model.data
                    )
                    self.userView.usersResult = newModel

                } else {
                    self.userView.usersResult = model // passando o valor da requisicao pra view
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func pagination(page: Int) {
        fetchRequest(page: page)
    }

}
