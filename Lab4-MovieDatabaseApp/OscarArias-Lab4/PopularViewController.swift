//
//  PopularViewController.swift
//  OscarArias-Lab4
//
//  Created by labuser on 10/24/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit

import UIKit

class PopularViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    var posters: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        activitySpinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchMovieData()
            self.cacheImages()
            
            DispatchQueue.main.async {
                self.activitySpinner.stopAnimating()
                self.movieCollectionView.reloadData()
            }
        }
        
        print(movies)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviecell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let posterFrame = CGRect(x: 0, y: 0, width: cell.contentView.frame.width, height: cell.contentView.frame.height - cell.contentView.frame.height/6)
        let poster = UIImageView(frame: posterFrame)
        poster.image = nil
        poster.image = posters[indexPath.row]
        cell.contentView.addSubview(poster)
        cell.isUserInteractionEnabled = true
        
        let titleFrame = CGRect(x: 0, y: cell.contentView.frame.height - cell.contentView.frame.height/6, width: cell.contentView.frame.width, height: cell.contentView.frame.height/6)
        let title = UILabel(frame: titleFrame)
        title.textAlignment = NSTextAlignment.center
        title.adjustsFontSizeToFitWidth = true
        title.text = nil
        title.text = movies[indexPath.row].title
        cell.contentView.addSubview(title)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushDetail3" {
            if let indexPath = self.movieCollectionView.indexPath(for: sender as! UICollectionViewCell) {
                let detailVC = segue.destination as? DetailedViewController
                detailVC!.movie = movies[indexPath.row]
                detailVC!.poster = posters[indexPath.row]
            }
        }
    }
    
    func fetchMovieData() {
        let json = getJSON("https://api.themoviedb.org/3/movie/now_playing?api_key=732fa3547ac0c8854e6cb8051027d15a&region=US&language=en-US&page=1")

        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let description = result["overview"].stringValue
            let posterUrl = "https://image.tmdb.org/t/p/w500" + result["poster_path"].stringValue
            let releaseDate = result["release_date"].stringValue
            let voteAverage = result["vote_average"].stringValue
            let id = result["id"].stringValue
            
            movies.append(Movie(title: title, description: description, posterUrl: posterUrl, release: releaseDate, voteAverage: voteAverage, id: id))
        }
    }
    
    
    func cacheImages() {
        for movie in movies {
            let url = URL(string: movie.posterUrl)
            if let data = try? Data(contentsOf: url!) {
                let image = UIImage(data: data)
                posters.append(image!)
            }
            else {
                posters.append(#imageLiteral(resourceName: "no_image_available.jpg"))
            }
        }
    }
    
    private func getJSON(_ url:String) -> JSON {
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                let json = try? JSON(data: data)
                return json!
            } else {
                return JSON.null
            }
        } else {
            
            return JSON.null
        }
    }
}

