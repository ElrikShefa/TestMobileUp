//
//  ChatsListAPI.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import Foundation

enum ChatsListAPI {}

extension ChatsListAPI {
    
    static func chatsListURL() -> URL? {
        return URL(string: "https://s3-eu-west-1.amazonaws.com/builds.getmobileup.com/storage/MobileUp-Test/api.json")
    }
}
