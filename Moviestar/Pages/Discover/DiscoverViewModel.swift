//
//  DiscoverViewModel.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation
import Entities
import API

protocol DiscoverViewModelDelegate: AnyObject {
    func discoverViewModel(_ viewModel: DiscoverViewModel, didLoad data: [MovieCell.ViewModel])
}

final class DiscoverViewModel {
    
    // MARK: - Properties
    weak var delegate: DiscoverViewModelDelegate?
    private let session: Session

    private var movies: [Movie] = [] {
        didSet {
            delegate?.discoverViewModel(self, didLoad: movies.map { movie in
                return MovieCell.ViewModel(
                    id: movie.id,
                    title: movie.title,
                    overview: movie.overview,
                    original_language: movie.original_language,
                    release_date: movie.release_date,
                    genre_ids: movie.genre_ids,
                    poster_path: movie.poster_path
                )
            })
        }
    }

    // MARK: - Init / ViewDidLoad
    init(session: Session) {
        self.session = session
    }

    func viewDidLoad() {
        Movie.getNowPlaying().response(using: session.client) {[weak self] response in
            print("--- EXAMPLE: Movies that are now playing in theatres ---")
            
            guard let self = self else { return }
            
            switch response {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.movies = movieResponse.results
                }
            case .failure(let error):
                print(error.failureReason)
            }
            print("--- END OF EXAMPLE ---")
        }
    }
    
    func didSearchForMovie(searchString: String) {
        Movie.getMoviesForSearch(searchString: searchString).response(using: session.client, completion: {[weak self] response in
            print("--- Searching for movies: \(searchString) ---")
            guard let self = self else { return }
            
            switch response {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.movies = movieResponse.results
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            print("--- END OF SEARCHING ---")
        })
    }
    
}
