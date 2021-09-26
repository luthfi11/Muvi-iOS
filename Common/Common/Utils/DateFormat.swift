//
//  DateFormat.swift
//  Common
//
//  Created by Dans Multipro on 20/09/21.
//

import Foundation

public final class DateFormat {
  
  public static func format(date: String) -> String {
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
