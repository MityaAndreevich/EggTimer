//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes: [String: Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var pleer: AVAudioPlayer!
   
    @IBOutlet weak var progressBar: UIProgressView!
      
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        guard let hardness = sender.currentTitle else { return }
        totalTime = eggTimes[hardness] ?? 0
        
        progressBar.progress = 0
        secondsPassed = 0
        doneLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self]timer in
            if secondsPassed < totalTime {
                secondsPassed += 1
                progressBar.setProgress(Float(secondsPassed) / Float(totalTime), animated: true)
            } else {
                timer.invalidate()
                doneLabel.text = "Done"
                playSounds()
            }
        }
    }
    
    func playSounds() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        pleer = try? AVAudioPlayer(contentsOf: url)
        pleer.play()
        }
    }


