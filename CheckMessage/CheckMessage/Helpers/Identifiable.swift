//
//  Identifiable.swift
//  CheckMessage
//
//  Created by Dmytro on 31.07.2024.
//

import Foundation

protocol CellIdentifiable {
    static var reuseIdentifier: String { get }
}

extension CellIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
