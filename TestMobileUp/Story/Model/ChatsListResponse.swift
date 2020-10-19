//
//  ChatsListResponse.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import Foundation

struct ChatsListResponse: Decodable {
    let user: User
    let message: Message
}

