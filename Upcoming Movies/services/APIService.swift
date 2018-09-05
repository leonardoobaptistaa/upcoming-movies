//
//  APIService.swift
//  Upcoming Movies
//
//  Created by Leonardo Baptista on 9/3/18.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class APIService: NSObject {
    let API_KEY = "1f54bd990f1cdfb230adb312546d765d"
    static var apiUrl = "https://api.themoviedb.org/3/"
    
    func defaultParams() -> Parameters {
        return [ "api_key": API_KEY ]
    }
    
    func upcomingMoviesURL() -> String {
        return APIService.apiUrl + "movie/upcoming"
    }
    
    func upcomingMoviesDataRequest(page: Int = 1) -> DataRequest {
        var params = defaultParams()
        params["page"] = page
        
        return Alamofire.request(upcomingMoviesURL(), parameters: params)
    }
    
    func upcomingMovies(page: Int = 1, onSuccess success: @escaping (_ movies: [Movie]) -> Void, onError error: (_ messages: [String]) -> Void ) {
        upcomingMoviesDataRequest(page: page).responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
            if let movies = response.result.value {
                success(movies)
            }
            else {
                print(response.result)
            }
            
        }
    }
}
