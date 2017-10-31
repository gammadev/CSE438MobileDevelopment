//
//  ViewController.swift
//  OscarArias-Lab2
//
//  Created by labuser on 9/23/17.
//  Copyright © 2017 WUSTL. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updatePet(pet: dog)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var dog = Pet(image: #imageLiteral(resourceName: "dog"), color: UIColor.red)
    var cat = Pet(image: #imageLiteral(resourceName: "cat"), color: UIColor.blue)
    var bird = Pet(image: #imageLiteral(resourceName: "bird"), color: UIColor.yellow)
    var bunny = Pet(image: #imageLiteral(resourceName: "bunny"), color: UIColor.green)
    var fish = Pet(image: #imageLiteral(resourceName: "fish"), color: UIColor.purple)
    
    var currentPet:Pet? = nil
    
    @IBOutlet weak var imageBackground: UIView!
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var happinessBar: DisplayView!
    @IBOutlet weak var happinessLevel: UILabel!
    @IBOutlet weak var foodLevel: UILabel!
    @IBOutlet weak var foodBar: DisplayView!
    @IBOutlet weak var trainingBar: DisplayView!
    @IBOutlet weak var trainingLevel: UILabel!

    
    @IBAction func dogButton(_ sender: Any) {
        updatePet(pet: dog)
    }

    @IBAction func catButton(_ sender: Any) {
        updatePet(pet: cat)
    }
    
    @IBAction func birdButton(_ sender: Any) {
        updatePet(pet: bird)
    }

    @IBAction func bunnyButton(_ sender: Any) {
        updatePet(pet: bunny)
    }
    
    @IBAction func fishButton(_ sender: Any) {
        updatePet(pet: fish)
    }
    
    func updatePet(pet: Pet) {
        imageBackground.backgroundColor = pet.color
        petImage.image = pet.image
        happinessBar.color = pet.color
        foodBar.color = pet.color
        trainingBar.color = pet.color
        
        updateLevels(pet: pet)
        
        currentPet = pet
    }
    
    func updateLevels(pet: Pet) {
        happinessLevel.text = "Played: " + String(pet.happiness)
        happinessBar.value = CGFloat(pet.happiness)/100
        
        foodLevel.text = "Fed: " + String(pet.food)
        foodBar.value = CGFloat(pet.food)/100
        
        trainingLevel.text = "Trained: " + String(pet.training)
        trainingBar.value = CGFloat(pet.training)/100
    }
    
    @IBAction func playButton(_ sender: Any) {
        if let pet = currentPet {
            pet.play()
            updateLevels(pet: pet)
        }
    }
    
    @IBAction func feedButton(_ sender: Any) {
        if let pet = currentPet {
            pet.feed()
            updateLevels(pet: pet)
        }
    }
    
    @IBAction func trainButton(_ sender: Any) {
        if let pet = currentPet {
            pet.train()
            updateLevels(pet: pet)
        }
    }
}

