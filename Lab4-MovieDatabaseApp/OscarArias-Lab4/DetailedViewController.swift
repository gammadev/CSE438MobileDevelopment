//
//  DetailedViewController.swift
//  OscarArias-Lab4
//
//  Created by labuser on 10/18/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var movie: Movie!
    var poster: UIImage!
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieInfo: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(movie.title)
        self.title = movie.title
        posterView.image = poster
        movieInfo.text = "Vote Average: \(movie.voteAverage) out of 10 \n\n Release Date: \(movie.release) \n\n \(movie.description)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveToFavorites(_ sender: Any) {
        let defaults = UserDefaults.standard
        if let temp = defaults.array(forKey: "movies") {
            var array = temp
            array.append(movie.title)
            defaults.set(array, forKey: "movies")
        }
        else {
            defaults.set([String](), forKey: "movies")
            var array = defaults.array(forKey: "movies") as! [String]
            array.append(movie.title)
            defaults.set(array, forKey: "movies")
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushWeb" {
            let webVC = segue.destination as? WebViewController
            webVC!.movieTitle = movie.title
        }
        
        if segue.identifier == "pushCredits" {
            let creditsVC = segue.destination as? CreditsViewController
            creditsVC!.movieID = movie.id
        }
        
        if segue.identifier == "pushRecommended" {
            let recommendedVC = segue.destination as? RecommendedViewController
            recommendedVC!.movieID = movie.id
            recommendedVC!.movieTitle = movie.title
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
