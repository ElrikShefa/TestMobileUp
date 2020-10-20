//
//  Date+Extension.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 20.10.2020.
//  Copyright © 2020 Matvey Chernyshov. All rights reserved.
//

import Foundation

extension Date {
    
    func formatRelativeString() -> String {
        
        let dateFormatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)
        
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.doesRelativeDateFormatting = true
        
        if calendar.isDateInToday(self) {
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
        } else if calendar.isDateInYesterday(self) {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
        } else if calendar.isDateInWeekend(self) {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .short
        } else if calendar.compare(Date(), to: self, toGranularity: .weekOfYear) == .orderedSame {
            let weekday = calendar.dateComponents([.weekday], from: self).weekday ?? 0
            return dateFormatter.weekdaySymbols[weekday-1]
        } else {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .short
        }
        
        return dateFormatter.string(from: self)
    }
    
}

extension String {
    
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter.date(from: self)
    }
    
}
