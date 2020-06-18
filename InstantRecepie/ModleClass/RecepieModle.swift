//
//  RecepieModle.swift
//  InstantRecepie
//
//  Created by MAC on 18/06/20.
//  Copyright © 2020 Techangouts. All rights reserved.
//

import Foundation

// MARK: - RecepieModle
struct RecepieModle: Codable {
    let title: String?
    let version: Double?
    let href: String?
    var results: [Result] = []
}

// MARK: - Result
struct Result: Codable {
    let title: String?
    let href: String?
    let ingredients: String?
    let thumbnail: String?
}

extension Result: Searchable {
    var searchableText: String {
        get {
            return (self.title ?? "")
        }
    }
}
