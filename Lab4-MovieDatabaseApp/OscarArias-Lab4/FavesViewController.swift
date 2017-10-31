//
//  FavesViewController.swift
//  OscarArias-Lab4
//
//  Created by labuser on 10/21/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit

class FavesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var movieTitles: [String] = []
    
    @IBOutlet weak var favesTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        favesTable.dataSource = self
        favesTable.delegate = self
        favesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movieTitles = []
        let defaults = UserDefaults.standard
        if let temp = defaults.array(forKey: "movies") {
            for movie in temp {
                movieTitles.append(movie as! String)
            }
        }
        else {
            defaults.set([String](), forKey: "movies")
        }
        print(movieTitles)
        favesTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel!.text = movieTitles[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTitles.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            movieTitles.remove(at: indexPath.row)
            
            let defaults = UserDefaults.standard
            defaults.set(movieTitles, forKey: "movies")
            favesTable.reloadData()
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
