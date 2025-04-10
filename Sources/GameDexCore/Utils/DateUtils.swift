//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation

public struct DateUtils {
    public static func formatDate(_ date: Date, format: String = "dd MMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public static func convertDateFormat(
            dateString: String,
            fromFormat: String,
            toFormat: String = "dd MMM yyyy"
        ) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = fromFormat
            formatter.locale = Locale(identifier: "en_US_POSIX")
            
            guard let date = formatter.date(from: dateString) else {
                return "Invalid Date"
            }
            
            formatter.dateFormat = toFormat
            return formatter.string(from: date)
        }
}
