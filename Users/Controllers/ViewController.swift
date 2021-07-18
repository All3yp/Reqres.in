//
//  ViewController.swift
//  Users
//
//  Created by Alley Pereira on 16/07/21.
//

import UIKit

class ViewController: UIViewController {

    let serviceManager = ServiceManager()

    // MARK: - TableView
    lazy var userView: UsersView = UsersView(frame: UIScreen.main.bounds)


    // MARK: - ViewController Lifecycle

    override func loadView() {
        super.loadView()
        self.view = userView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Users"
        fetchRequest()

    }


    // MARK: - Request
    func fetchRequest() {
        let urlRequest = URLRequest.init(url: serviceManager.baseURl!)

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
                self.userView.usersResult = model // passando o valor da requisicao pra view

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

