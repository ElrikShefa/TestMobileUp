//
//  TableView+Extension.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 20.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//


import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .tintGray()
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 15, weight: .regular)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
