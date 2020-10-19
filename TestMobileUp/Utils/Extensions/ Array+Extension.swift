//
//  Array+Extension.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//


import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        guard index >= 0 else { return nil }
        
        return self[safe: UInt(index)]
    }
    
    subscript(safe index: UInt) -> Element? {
        guard isNotEmpty,
              index < count
        else { return nil }
        
        return self[index]
    }
    
    subscript(index: UInt) -> Element {
        return self[Int(index)]
    }
}

extension Array where Element == TimeInterval {
    
    var sum: TimeInterval {
        return reduce(0, +)
    }
}
