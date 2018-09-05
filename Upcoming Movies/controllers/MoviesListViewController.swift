//
//  MoviesListViewController.swift
//  Upcoming Movies
//
//  Created by Leonardo Baptista on 9/4/18.
//

import UIKit
import AlamofireImage

class MoviesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies : [Movie] = []
    var page = 0
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Upcoming Movies"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    // MARK: - Fetch
    func fetchMovies() {
        page += 1
        APIService().upcomingMovies(page: page, onSuccess: { (_movies) in
            var startingIndex = self.movies.count - 1
            let indexPaths : [IndexPath] = _movies.map { _ in
                startingIndex += 1
                return IndexPath(row: startingIndex, section: 0)
            }
            
            self.movies.append(contentsOf: _movies)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
        }) { (errorMessages) in
            //TODO: Deal with errors
        }
    }
    
    func fetchMoviesAndClean() {
        page = 1
        APIService().upcomingMovies(page: page, onSuccess: { (movies) in
            self.movies = movies
            self.tableView.reloadData()
        }) { (errorMessages) in
            //TODO: Deal with errors
        }
    }
    
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") else {
            fatalError("MovieCell is not configured")
        }
        
        cell.textLabel?.text = movie.name
        cell.detailTextLabel?.text = "\(movie.genres) - \(movie.releaseDateAsText())"
        setImage(imagePath: movie.thumbURLPath, forCell: cell)
        
        return cell
    }
    
    func setImage(imagePath: String, forCell cell: UITableViewCell) {
        let url = URL(string: imagePath)!
        cell.imageView?.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.crossDissolve(0.3), runImageTransitionIfCached: false, completion: { (image) in
            cell.setNeedsLayout()
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            fetchMovies()
        }
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//        if maximumOffset - currentOffset <= 10.0 {
//            fetchMovies()
//        }
//    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let triggerIndex = movies.count - 2
//        guard triggerIndex > 0 else {
//            return
//        }
//
//        if (triggerIndex == indexPath.row) {
//            fetchMovies()
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieController = segue.destination as! MovieDetailViewController
        guard let sender = sender as? UITableViewCell else {
            fatalError("Only UITableViewCell should call this segue")
        }
        
        guard let indexPath = tableView.indexPath(for: sender) else {
            fatalError("Where is this cell?")
        }
        
        movieController.movie = movies[indexPath.row]
        movieController.preloadedImage = sender.imageView?.image
    }
}
