//
//  DateManager.swift
//  ChatChat
//
//  Created by 박연배 on 2022/01/14.
//

import Foundation

class DateManager {
    static let shared = DateManager()
    let dateFormatter = DateFormatter()
    
    private init() {
        
    }
    
    func stringToDate(string: String) -> Date {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        return dateFormatter.date(from: string)!
    }
    
    func dateToString(date: Date) -> String {
        dateFormatter.dateFormat = "MM/dd일 a HH:mm"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        return dateFormatter.string(from: date)
    }
}
