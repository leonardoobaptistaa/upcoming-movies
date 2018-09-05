//
//  MovieDetailViewController.swift
//  Upcoming Movies
//
//  Created by Leonardo Baptista on 9/4/18.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie : Movie?
    var preloadedImage : UIImage?
    
    @IBOutlet weak var imgPoster : UIImageView!
    @IBOutlet weak var viewInfos : UIView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblInfos : UILabel!
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setInfo()
        setImage()
    }
    
    // MARK: - Data
    
    func setInfo() {
        guard let movie = self.movie else {
            return
        }
        
        imgPoster.image = preloadedImage
        lblName.text = movie.name
        lblInfos.text = "Release Date: \(movie.releaseDateAsText())\nGenres: \(movie.genres)\n\n\(movie.overview)"
    }
    
    func setImage() {
        let url = URL(string: movie!.imageURLPath)!
        
        imgPoster.af_setImage(withURL: url, placeholderImage: preloadedImage, filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false, completion: { (image) in
            self.view.setNeedsLayout()
        })
    }
    
    // MARK: - Events
    
    @IBAction func toggleInfo(sender: UIButton) {
        let shouldHide = self.viewInfos.alpha == 1
        if shouldHide {
            hideInfo()
        }
        else {
            showInfo()
        }
    }
    
    func hideInfo() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate(withDuration: 0.3) {
            self.viewInfos.alpha = 0
        }
    }
    
    func showInfo() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIView.animate(withDuration: 0.3) {
            self.viewInfos.alpha = 1
        }
    }
}
