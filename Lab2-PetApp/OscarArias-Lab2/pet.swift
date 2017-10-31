//
//  pet.swift
//  OscarArias-Lab2
//
//  Created by labuser on 9/24/17.
//  Copyright © 2017 WUSTL. All rights reserved.
//

import Foundation
import UIKit

class Pet {
    var image: UIImage
    var color: UIColor
    var food: Int
    var happiness: Int
    var training: Int
    
    init(image: UIImage, color: UIColor) {
        self.image = image
        self.color = color
        self.food = 40
        self.happiness = 35
        self.training = 25
    }
    
    func play() {
        self.happiness += 5
        self.food -= 8
        self.training -= 10
        
        if self.happiness > 100 {
            self.happiness = 100
        }
        
        if self.food < 0 {
            self.food = 0
        }
        
        if self.training < 0 {
            self.training = 0
        }
    }
    
    func feed() {
        self.happiness -= 5
        self.food += 10
        self.training -= 2
        
        if self.happiness < 0 {
            self.happiness = 0
        }
        
        if self.food > 100 {
            self.food = 100
        }
        
        if self.training < 0 {
            self.training = 0
        }
    }
    
    func train() {
        self.happiness -= 10
        self.food -= 15
        self.training += 15
        
        if self.happiness < 0 {
            self.happiness = 0
        }
        
        if self.food < 0 {
            self.food = 0
        }
        
        if self.training > 100 {
            self.training = 100
        }
    }
}
