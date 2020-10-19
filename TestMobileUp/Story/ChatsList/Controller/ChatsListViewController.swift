//
//  ChatsListViewController.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//

import UIKit

final class ChatsListViewController: BaseVC {
    
    //MARK: - private propertys
    private typealias CellType = ChatsListCellVC
    
    private let heightCell: CGFloat = 76
    private var chatsList = [ChatsListResponse](){
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
     
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - private propertys
    private lazy var tableView = UITableView()


    //MARK: - method lIfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadChatsList()
    }

}

//MARK: - tableView protocols
extension ChatsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return chatsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return tableView.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier, for: indexPath)
    }
    
}

extension ChatsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightCell
    }

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
        tableView.register(UINib(nibName: CellType.nibName, bundle: nil), forCellReuseIdentifier: CellType.reuseIdentifier)


            view.addSubview(tableView)
   
        NSLayoutConstraint.activate(tableView.edgeConstraints(to: view.safeAreaLayoutGuide))
    }
    
    func loadChatsList() {
        
        Networking.getChat(onSuccess: { [weak self] receivedСhatsList in
            guard let self = self else { return }
            print(receivedСhatsList)
            self.chatsList = receivedСhatsList.map{$0}
        },
        onFailure: { [weak self] error in
            guard let self = self else { return }
            
            switch error {
            
            case .internetIsNotAvailable(_):
                self.monitorNetwork()
                
            case .serverNotResponding:
                self.monitorNetworkServer()
            
            case .jsonDecodingError(let jsonDecodingError):
                self.showAlert(message: jsonDecodingError.localizedDescription)
                
            case .badImageData(let responseData):
                self.showAlert(message: "Bad response image data: \(responseData.description)")
            }
        },
        url: ChatsListAPI.chatsListURL())
    }
    
    private func setupImage(imageURL: URL, cell: CellType) {
        
        Networking.downloadImage(
            url: imageURL,
            onSuccess: { [weak cell] image in
                guard let cell = cell else { return }
                cell.avatarImage = image
            },
            onFailure: { [weak self] error in
                guard let self = self else { return }
                
                switch error {
                case .internetIsNotAvailable(_):
                    self.monitorNetwork()
                    
                case .serverNotResponding:
                    self.monitorNetworkServer()
            
                case .jsonDecodingError(let jsonDecodingError):
                    self.showAlert(message: jsonDecodingError.localizedDescription)
                    
                case .badImageData(let responseData):
                    self.showAlert(message: "Bad response image data: \(responseData.description)")
                }
            }
        )
    }
}
