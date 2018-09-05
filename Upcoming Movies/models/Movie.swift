//
//  Movie.swift
//  Upcoming Movies
//
//  Created by Leonardo Baptista on 9/3/18.
//

import UIKit
import ObjectMapper

class Movie: Mappable {
    var name: String = ""
    var thumbURLPath: String = ""
    var imageURLPath: String = ""
    var genres: String = ""
    var releaseDate: Date = Date()
    var overview: String = ""
    
    //caching formatter for perfomance
    static let defaultFormatter = DateFormatter(withFormat: "yyyy-MM-dd", locale: Locale.current.languageCode ?? "en")
    
    static let availableGenres = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
    
    required init?(map: Map){
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        name <- map["title"]
        thumbURLPath <- (map["poster_path"], urlTransformation(size: 92))
        imageURLPath <- (map["poster_path"], urlTransformation(size: 500))
        genres <- (map["genre_ids"], genresTransformation())
        releaseDate <- (map["release_date"], dateTransformation())
        overview <- map["overview"]
    }
    
    func urlTransformation(size: Int = 500) -> TransformOf<String, String> {
        return TransformOf<String, String>(fromJSON: { "https://image.tmdb.org/t/p/w\(size)\($0 ?? "")" }, toJSON: { $0 })
    }
    
    func dateTransformation() -> TransformOf<Date, String> {
        return TransformOf<Date,String>(fromJSON: { (dateAsString: String?) -> Date? in
            return Movie.defaultFormatter.date(from: dateAsString ?? "1970-01-01")
        }, toJSON: { (date:Date?) -> String? in
            return Movie.defaultFormatter.string(from: date ?? Date())
        })
    }
    
    func genresTransformation() -> TransformOf<String, [Int]> {
        return TransformOf<String, [Int]>(fromJSON: { (_genresIDS:[Int]?) -> String? in
            let genresIDS = _genresIDS ?? []
            let genresArray: [String] = genresIDS.map { Movie.availableGenres[$0] ?? "" }.filter { $0 != "" }
            return genresArray.joined(separator: ", ")
        }, toJSON: { (value: String?) -> [Int]? in
            return []
        })
    }
    
    func releaseDateAsText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: releaseDate)
    }
}
