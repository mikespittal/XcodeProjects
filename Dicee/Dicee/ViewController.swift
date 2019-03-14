//
//  ViewController.swift
//  Dicee
//
//  Created by Mikey  on 26/01/2018.
//  Copyright © 2018 mechatron08. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomIndex1 : Int = 0
    var randomIndex2 : Int = 0
    var temp : Int = 0
    let dicearray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6",]
    
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateDiceImages()
    }
    func updateDiceImages () {
        randomIndex1 = Int(arc4random_uniform(6))
        randomIndex2 = Int(arc4random_uniform(6))
        //        let name : String = "dice" + String(randomIndex1)
        //        let name2 : String = "dice" + String(randomIndex2)
        //        print(randomIndex1)
        //        print(randomIndex2)
        diceImageView.image = UIImage(named: dicearray[randomIndex1])
        diceImageView2.image = UIImage(named: dicearray[randomIndex2])
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
}

