//
//  Image+Extension.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//


import UIKit

enum SystemIcon: String {
    
    case chevron = "chevron.right"
}

extension UIImage {
    
    convenience init(systemIcon: SystemIcon) {
        self.init(systemName: systemIcon.rawValue)!
    }
}
