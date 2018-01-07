//
//  ViewController.swift
//  WarApp
//
//  Created by Marvin Laucher on 1/1/18.
//  Copyright © 2018 Marvin Laucher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var username = String()

    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftScoreLabel: UILabel!
    
   
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    @IBOutlet weak var Player: UILabel!
    
    
    var leftScore = 0
    var rightScore = 0
    
    
    
    
    override func viewDidLoad() {
        self.Player.text = self.username
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutButton(_ sender: Any) {
         self.performSegue(withIdentifier: "showLogIn", sender: self)
    }
    
    @IBAction func dealTapped(_ sender: Any) {
       // Randomize two numbers
        let leftRandomNumber = arc4random_uniform(13) + 2
        
        
        let rightRandomNumber = arc4random_uniform(13) + 2
      
        // change the image views(cards)
        leftImageView.image = UIImage(named: "card\(leftRandomNumber)")
        
        rightImageView.image = UIImage(named: "card\(rightRandomNumber)")
        
        // Compare the numbers
        if leftRandomNumber > rightRandomNumber {
            
            //update left score for win
            leftScore += 1
            
            //update label
            leftScoreLabel.text = String(leftScore)
            
            
            
        }
        else if rightRandomNumber > leftRandomNumber {
           
            // update right score for win
            rightScore += 1
            
            //update label
            rightScoreLabel.text = String(rightScore)
            
        }
        else if leftRandomNumber == rightRandomNumber {
            
            //update left score for Tie
            leftScore += 1
            
            //update label
            leftScoreLabel.text = String(leftScore)
            
            // update right score for Tie
            rightScore += 1
            
            //update label
            rightScoreLabel.text = String(rightScore)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SocialLogInController{
            let nextcontroller = (segue.destination as! SocialLogInController)
            nextcontroller.logout = "true"
        }
    }

}

