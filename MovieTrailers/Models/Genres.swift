//
//  Genres.swift
//  MovieTrailers
//
//  Created by Oğuzhan Varsak on 4.06.2022.
//

import Foundation

typealias GenreList = [Genre]

struct Genres: Decodable {
    let genres: GenreList?
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
}
