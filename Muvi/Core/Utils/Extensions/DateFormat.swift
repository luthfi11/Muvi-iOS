//
//  DateFormatter.swift
//  Muvi
//
//  Created by Dans Multipro on 23/08/21.
//

import Foundation

final class DateFormat {
  
  static func format(date: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd MMM yyyy"
    
    if let date = dateFormatterGet.date(from: date) {
      return dateFormatterPrint.string(from: date)
    } else {
      return "Unknown"
    }
  }
}
