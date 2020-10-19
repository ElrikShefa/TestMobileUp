//
//  Message.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//


import Foundation

struct Message: Decodable {
    
    let text: String
    let receivingDate: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.text = try container.decode(String.self, forKey: .text)
        self.receivingDate = try container.decode(String.self, forKey: .receivingDate)
    }
}

private extension Message {
    
    enum CodingKeys: String, CodingKey {
        case text
        case receivingDate = "receiving_date"
    }
}
