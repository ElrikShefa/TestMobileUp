//
//  User.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    let nickname: String
    let avatarUrl: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.nickname = try container.decode(String.self, forKey: .nickname)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
    }
}

private extension User {
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case avatarUrl = "avatar_url"
    }
}
