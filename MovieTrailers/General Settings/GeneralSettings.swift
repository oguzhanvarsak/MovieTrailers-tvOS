//
//  GeneralSettings.swift
//  MovieTrailers
//
//  Created by Oğuzhan Varsak on 5.06.2022.
//

import Foundation

struct GeneralSettings {
    struct Url {
        static var category = "https://api.themoviedb.org/3/genre/movie/list?api_key=3bb3e67969473d0cb4a48a0dd61af747&language=en-US"
        static var categoryDetail = "https://api.themoviedb.org/3/discover/movie?api_key=3bb3e67969473d0cb4a48a0dd61af747&sort_by=popularity.desc&page=1&with_genres=%@"
        static var poster = "https://image.tmdb.org/t/p/w780%@"
        static var video = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
        static var images = "https://api.themoviedb.org/3/movie/%@/images?api_key=3bb3e67969473d0cb4a48a0dd61af747&language=en"
    }
}
