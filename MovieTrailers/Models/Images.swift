//
//  Images.swift
//  MovieTrailers
//
//  Created by Oğuzhan Varsak on 5.06.2022.
//

import Foundation

struct Images: Codable {
    let backdrops: [Image]?
    let logos: [Image]?
    let posters: [Image]?
}

struct Image: Codable {
    let aspectRatio: Int?
    let height: Int?
    let iso639: Int?
    let filePath: Int?
    let voteAverage: Int?
    let voteCount: Int?
    let width: Int?
    
    enum CodingKeys: String, CodingKey {
        case height, width
        case aspectRatio = "aspect_ratio"
        case iso639 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
