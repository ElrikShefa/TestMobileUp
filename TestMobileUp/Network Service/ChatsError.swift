//
//  ChatsError.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import Foundation

enum ChatsError {
    
    case internetIsNotAvailable(_ connectedError: Error)
    case serverNotResponding
    
    case badImageData(_ responseData: Data)
    case jsonDecodingError(_ jsonDecodingError: Error)
}
