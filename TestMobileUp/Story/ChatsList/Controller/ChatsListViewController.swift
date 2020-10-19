//
//  ChatsListViewController.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//

import UIKit

final class ChatsListViewController: BaseVC {
    
    //MARK: - private propertys
    private lazy var tableView = UITableView()


    //MARK: - method lIfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


}

//MARK: - tableView protocols
extension ChatsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
}

extension ChatsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - private methods
private extension ChatsListViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationBar(largeTitleColor: .black, backgoundColor: .tintBlue(), tintColor: .red, title: StringConstants.title, preferredLargeTitle: true)

        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")


            view.addSubview(tableView)
   
        NSLayoutConstraint.activate(tableView.edgeConstraints(to: view.safeAreaLayoutGuide))
    }
}
