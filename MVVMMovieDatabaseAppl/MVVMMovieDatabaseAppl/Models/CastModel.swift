//
//  CastModel.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import Foundation

struct Cast: Codable {
    let character: String
    let name: String

}

struct CreditsResponse: Codable {
    let cast: [Cast]
}
