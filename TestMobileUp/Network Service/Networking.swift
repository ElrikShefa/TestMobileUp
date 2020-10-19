//
//  Networking.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import UIKit

enum Networking {}

extension Networking {
    
    static func getChat(
        onSuccess: @escaping ([ChatsListResponse]) -> Void,
        onFailure: @escaping (ChatsError) -> Void,
        url: URL?
    ) {
        guard let url = url else { return }
        
        NetworkSettings.urlSession.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                onFailure(.internetIsNotAvailable(error))
                return
            }
            
            guard let data = data else {
                onFailure(.serverNotResponding)
                return
            }
            
            do {
                let result = try JSONDecoder().decode([ChatsListResponse].self, from: data)
                
                onSuccess(result.map{ $0 })
            } catch let jsonDecodingError {
                onFailure(.jsonDecodingError(jsonDecodingError))
            }
        }.resume()
    }
    
    static func downloadImage(
        url: URL,
        onSuccess: @escaping (UIImage) -> Void,
        onFailure: @escaping (ChatsError) -> Void
    ) {
        NetworkSettings.urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                onFailure(.internetIsNotAvailable(error))
                return
            }
            
            guard let data = data else {
                onFailure(.serverNotResponding)
                return
            }
            
            guard let image = UIImage(data: data) else {
                onFailure(.badImageData(data))
                return
            }
            
            onSuccess(image)
        }.resume()
    }

}
