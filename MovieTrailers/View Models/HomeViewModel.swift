//
//  HomeViewModel.swift
//  MovieTrailers
//
//  Created by Oğuzhan Varsak on 4.06.2022.
//

import Foundation

protocol HomeViewModelDelegate: NSObject {
    func reloadItems()
}

final class HomeViewModel {
    
    private var service: WebService?
    
    private var genres: GenreList?
    private var movies: [MovieList]?
    
    weak var delegate: HomeViewModelDelegate?
    
    init() {
        self.service = WebService()
    }
    
    func getGenres() {
        service?.getData(from: GeneralSettings.Url.category,
                         for: Genres.self, completion: { data in
            if let dataList: Genres = try? data.get() {
                self.genres = dataList.genres
                
                
                if let genres = dataList.genres {
                    for genre in genres {
                        self.getMovies(for: genre.name!)
                        self.delegate?.reloadItems()
                    }
                }
            }
        })
    }
    
    func getMovies(for genre: String) {
        service?.getData(from: String(format: GeneralSettings.Url.categoryDetail, genre), for: Movies.self, completion: { data in
            if let dataList: Movies = try? data.get() {
                if let movies = self.movies {
                    self.movies?.append(dataList.results!)
                } else {
                    self.movies = [MovieList]()
                }
            }
        })
    }
}

extension HomeViewModel {
    
    var numberOfSections: Int {
        self.genres?.count ?? 0
    }
    
    func movieAtIndex(_ index: Int) -> Movie? {
        return movies?[index][index]
    }
    
    func genreAtIndex(_ index: Int) -> String {
        return genres?[index].name ?? ""
    }
}
