//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var player : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
    }



    @IBAction func notePressed(_ sender: UIButton) {
        let note : String = "note" + String(sender.tag)
        let soundUrl = Bundle.main.url(forResource: note, withExtension: "wav")
        do{
           player = try AVAudioPlayer(contentsOf: soundUrl!)
        }catch{
            print(error)
        }
        player.play()
    }
    
  

}

