//
//  CreditsViewController.swift
//  OscarArias-Lab4
//
//  Created by labuser on 10/24/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movieID: String = "hello"
    var cast: [[String]] = []
    var crew: [[String]] = []
    
    @IBOutlet weak var creditsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        creditsTable.dataSource = self
        creditsTable.delegate = self
        creditsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchMovieData()
        creditsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        if self.title == "Cast" {
            cell.textLabel!.text = cast[indexPath.row][0] + " .......... " + cast[indexPath.row][1]
        }
        else {
            cell.textLabel!.text = crew[indexPath.row][0] + " .......... " + crew[indexPath.row][1]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.title == "Cast" {
            return cast.count
        }
        return crew.count
    }
    
    @IBAction func showCast(_ sender: Any) {
        self.title = "Cast"
        creditsTable.reloadData()
    }

    @IBAction func showCrew(_ sender: Any) {
        self.title = "Crew"
        creditsTable.reloadData()
        
    }
    
    func fetchMovieData() {
        let json = getJSON("https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=732fa3547ac0c8854e6cb8051027d15a")
        print(movieID)
        for person in json["cast"].arrayValue {
            print(person)
            let character = person["character"].stringValue
            print(character)
            let name = person["name"].stringValue
            print(name)
            
            if character != "" && name != "" {
                cast.append([character, name])
            }
        }
        
        for person in json["crew"].arrayValue {
            let job = person["job"].stringValue
            let name = person["name"].stringValue
            
            if job != "" && name != "" {
                crew.append([job, name])
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
