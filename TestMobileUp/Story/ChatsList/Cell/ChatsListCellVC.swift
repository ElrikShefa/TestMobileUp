//
//  ChatsListCellVC.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import UIKit

final class ChatsListCellVC: UITableViewCell {
    
    var avatarImage: UIImage? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.avatarImageView.image = self.avatarImage
            }
        }
    }

    @IBOutlet var currentDateTime: UILabel!
    @IBOutlet var userMessage: UILabel!
    @IBOutlet var userNickname: UILabel!
    @IBOutlet var chevroneView: UIImageView!
    @IBOutlet var avatarImageView: UIImageView!{
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initials()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        initials()
    }
    
    func set(nickname: String, message: String, date: String) {
        userNickname.text = nickname
        userMessage.text = message
        currentDateTime.text = date
    }

}

private extension ChatsListCellVC  {
    
    func initials() {
        avatarImageView.image = nil
        userMessage.text = nil
        userNickname.text = nil
        currentDateTime.text = nil
        chevroneView.image = UIImage(systemIcon: .chevron)
    }
}
