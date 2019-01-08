//
//  DateExtension.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 08/12/18.
//  Copyright © 2018 Adriano Song. All rights reserved.
//

import Foundation

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.date(from: customString) ?? Date()
    }
}
