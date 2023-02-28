//
//  DateFormatter+Extensions.swift
//  UnitFive-BeReal
//
//  Created by Liana Adaza on 2/27/23.
//

import Foundation

extension DateFormatter {
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
}
