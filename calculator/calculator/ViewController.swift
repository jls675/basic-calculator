//
//  ViewController.swift
//  calculator
//
//  Created by Jorge Sanchez on 1/31/19.
//  Copyright © 2019 Jorge Sanchez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer!
    var arrayOfNum = [Double]()
    var onScreen: Double = 0
    var currentOP = ""
    
    
    @IBOutlet weak var numberDisplay: UILabel!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet var opListIncludingEqual: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dotButton.setTitle(".", for: .normal)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if sender.tag != 16 {
            numberDisplay.text = numberDisplay.text! + String(sender.tag - 1)
            onScreen = Double(numberDisplay.text!)!
        }
        else {
            numberDisplay.text = numberDisplay.text! + dotButton.title(for: .normal)!
            dotButton.isEnabled = false
        }
        equalButton.isEnabled = true
    }
    
    
    @IBAction func operandButtonPressed(_ sender: UIButton) {
        
        dotButton.isEnabled = true
        arrayOfNum.append(onScreen)
        disableOP()//inculdes the equal sign
        
        if sender.tag == 11{
            currentOP = "+"
            numberDisplay.text = ""
            
        }
        else if sender.tag == 12{
            currentOP = "-"
            numberDisplay.text = ""
            
        }
        else if sender.tag == 13{
            currentOP = "*"
            numberDisplay.text = ""
            
        }
        else if sender.tag == 14{
            currentOP = "/"
            numberDisplay.text = ""
            
        }
        else {
            
            enableOP()
            
            if currentOP == "+"{
                numberDisplay.text = String(arrayOfNum[0] + arrayOfNum[1])
                onScreen = Double(numberDisplay.text!)!
                arrayOfNum.remove(at: 0)
                arrayOfNum.remove(at: 0)
            }
            else if currentOP == "-"{
                numberDisplay.text = String(arrayOfNum[0] - arrayOfNum[1])
                onScreen = Double(numberDisplay.text!)!
                arrayOfNum.remove(at: 0)
                arrayOfNum.remove(at: 0)
            }
            else if currentOP == "*"{
                numberDisplay.text = String(arrayOfNum[0] * arrayOfNum[1])
                onScreen = Double(numberDisplay.text!)!
                arrayOfNum.remove(at: 0)
                arrayOfNum.remove(at: 0)
            }
            else if currentOP == "/"{
                numberDisplay.text = String(arrayOfNum[0] / arrayOfNum[1])
                onScreen = Double(numberDisplay.text!)!
                arrayOfNum.remove(at: 0)
                arrayOfNum.remove(at: 0)
            }
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        numberDisplay.text = ""
        currentOP = ""
        arrayOfNum = []
        enableOP()
        equalButton.isEnabled = false
        dotButton.isEnabled = true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        playSound()
    }
    
    func playSound(){
        let soundURL = Bundle.main.url(forResource: "hero", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
    
    func enableOP(){
        for button in opListIncludingEqual{
            button.isEnabled = true
        }
    }
    
    func disableOP(){
        for button in opListIncludingEqual{
            button.isEnabled = false
        }
    }
    
}

