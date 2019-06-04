//
//  ITunesSearchResult.swift
//  iOSArchitecturesDemo
//
//  Created by Olga Martyanova on 19.02.2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import Foundation

struct ITunesSearchResult<Element: Codable>: Codable {
    let resultCount: Int
    let results: [Element]
}
