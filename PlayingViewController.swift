//
//  PlayingViewController.swift
//  Tap of War
//
//  Created by DPI Student 47 on 7/12/22.
//

import UIKit
import AVFoundation

class PlayingViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var middle: CGFloat!
    var middleWidth: CGFloat!
    @IBOutlet weak var countdownLabel: UILabel!
    var started: Bool!
    var ended: Bool!
    
    var blueTapCount: Int!
    var redTapCount: Int!
    var SPEED: Int!
    
    var blueWin: Int = 0
    @IBOutlet weak var blueWinLabel: UILabel!
    var redWin: Int = 0
    @IBOutlet weak var redWinLabel: UILabel!
    
    @IBOutlet weak var redResult: UILabel!
    @IBOutlet weak var blueResult: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet var redViewTap: UITapGestureRecognizer!
    @IBOutlet var backgroundTap: UITapGestureRecognizer!
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    
    
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "click.mp3", ofType:nil)!)
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SPEED = Int(self.view.frame.height) / 75
        
        middle = view.frame.height / 2
        middleWidth = view.frame.width / 2

        redResult.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
       
        redViewTap.delegate = self
        backgroundTap.delegate = self
        
        fullStart()
    }
    
    func fullStart() {
        redResult.layer.opacity = 0
        blueResult.layer.opacity = 0
        countdownLabel.isHidden = true
        countdownLabel.layer.opacity = 1
        restartButton.isHidden = true
        exitButton.isHidden = true
        countdownLabel.text = "3"
        blueWinLabel.text = String(blueWin)
        redWinLabel.text = String(redWin)
        blueWinLabel.layer.borderColor = UIColor.black.cgColor
        redWinLabel.layer.borderColor = UIColor.black.cgColor
        blueWinLabel.layer.borderWidth = 1
        redWinLabel.layer.borderWidth = 1
//        heightConstraint.constant = 0
        
        blueTapCount = 0
        redTapCount = 0
        
        started = false
        ended = false
        
        self.heightConstraint.constant = self.middle
        UIView.animate(withDuration: 1.5,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            animations: {
            self.view.layoutIfNeeded()
            },
            completion: countdown
        )
    }
    
    func countdown(_ l: Bool) {
        countdownLabel.text = "3"
        countdownLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.countdownLabel.text = "2"
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.countdownLabel.text = "1"
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.countdownLabel.text = "Start!"
        })
        UIView.animate(withDuration: 0.5, delay: 4.2, animations: {
            self.countdownLabel.layer.opacity = 0
        }, completion: {_ in
            self.started = true
        })
        
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        if started && !ended {
            do {
                 audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
                 audioPlayer.play()
            } catch {
               // couldn't load file :(
            }
            if sender.view == blueView {
                blueTapCount += 1
                print("blue")
            } else {
                redTapCount += 1
                print("red")
            }
            heightConstraint.constant = middle + CGFloat((redTapCount - blueTapCount) * SPEED)
//            UIView.animate(withDuration: 0.1, animations: {
                self.view.layoutIfNeeded()
//            })
            
            if abs(abs(heightConstraint.constant - middle) - middle) <= self.view.frame.height * 9 / 100 {
                started = false
                ended = true
                
                let winner = heightConstraint.constant < middle // True, red won, False blue won
                heightConstraint.constant = heightConstraint.constant < middle ? CGFloat(0) : self.view.frame.height
                
                restartButton.isHidden = false
                exitButton.isHidden = false
                restartButton.layer.opacity = 0
                exitButton.layer.opacity = 0
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                    self.restartButton.layer.opacity = 1
                    self.exitButton.layer.opacity = 1
                    if !winner {
                        self.redWin += 1
                        self.redResult.layer.opacity = 1
                    } else {
                        self.blueWin += 1
                        self.blueResult.layer.opacity = 1
                    }
                }, completion: {_ in
                    self.blueWinLabel.text = String(self.blueWin)
                    self.redWinLabel.text = String(self.redWin)
                })
                
            }
        }
    }
    
    @IBAction func onRestartClick() {
        if !started && ended {
            fullStart()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var next = segue.destination as! ViewController
    }

//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        return gestureRecognizer == redViewTap
//    }
}
