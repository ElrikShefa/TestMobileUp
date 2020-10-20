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
                
                let chatsListAreNotEmpty = self.chatsList.isNotEmpty
                
                self.emptyViewActivityIndicator.isHidden = chatsListAreNotEmpty
                self.emptyViewLabel.isHidden = chatsListAreNotEmpty
                self.tableView.isHidden = !chatsListAreNotEmpty
                
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - private propertys
    private lazy var tableView = UITableView()
    private lazy var refreshControl = UIRefreshControl()
    private lazy var emptyViewActivityIndicator = UIActivityIndicatorView(style: .medium)
    private lazy var emptyViewLabel = UILabel()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier, for: indexPath)
        
        guard
            let castedCell = cell as? CellType,
            let chat = chatsList[safe: indexPath.row],
            let date = chat.message.receivingDate.date
            else { return cell}
        
        if let url = URL(string: chat.user.avatarUrl) {
            setupImage(imageURL: url, cell: castedCell)
        } else {
            castedCell.avatarImage = UIImage(named: "Empty avatar")
        }
        
        castedCell.set(nickname: chat.user.nickname, message: chat.message.text, date: date.formatRelativeString())
        
        return castedCell
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
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.backgroundColor = nil
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CellType.nibName, bundle: nil), forCellReuseIdentifier: CellType.reuseIdentifier)
        tableView.isHidden = true
        
        emptyViewLabel.font = .systemFont(ofSize: 18, weight: .light)
        emptyViewLabel.textColor = .tintGray()
        emptyViewLabel.textAlignment = .center
        emptyViewLabel.text = StringConstants.loading
        
        emptyViewActivityIndicator.startAnimating()
        
        [tableView, emptyViewLabel, emptyViewActivityIndicator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: tableView.edgeConstraints(to: view.safeAreaLayoutGuide))
        constraints.append(contentsOf: emptyViewActivityIndicator.centerConstraints(to: tableView))
        constraints.append(contentsOf: [
            emptyViewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 64),
            emptyViewLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -64),
            emptyViewLabel.topAnchor.constraint(equalTo: emptyViewActivityIndicator.bottomAnchor, constant: 5),
        ])
        NSLayoutConstraint.activate(constraints)
    }
    
    func loadChatsList() {
        
        Networking.getChat(onSuccess: { [weak self] receivedСhatsList in
            guard let self = self else { return }
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
    
    @objc func refresh(sender: UIRefreshControl) {
        loadChatsList()
        tableView.reloadData()
        sender.endRefreshing()
    }
    
}
