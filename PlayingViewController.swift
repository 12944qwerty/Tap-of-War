//
//  PlayingViewController.swift
//  Tap of War
//
//  Created by DPI Student 47 on 7/12/22.
//

import UIKit

class PlayingViewController: UIViewController {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var middle: CGFloat!
    var middleWidth: CGFloat!
    @IBOutlet weak var countdownLabel: UILabel!
    var started: Bool!
    var ended: Bool!
    
    var blueTapCount: Int!
    var redTapCount: Int!
    var SPEED: Int!
    
    @IBOutlet weak var redResult: UILabel!
    @IBOutlet weak var blueResult: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SPEED = Int(self.view.frame.height) / 50
        
        middle = view.frame.height / 2
        middleWidth = view.frame.width / 2

        redResult.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
       
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
            if sender.view == self.view {
                blueTapCount += 1
            } else {
                redTapCount += 1
            }
            heightConstraint.constant = middle + CGFloat((blueTapCount - redTapCount) * SPEED)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
            if abs(abs(heightConstraint.constant - middle) - middle) <= self.view.frame.height * 9 / 100 {
                started = false
                ended = true
                
                var winner = heightConstraint.constant < middle // True, red won, False blue won
                heightConstraint.constant = heightConstraint.constant < middle ? CGFloat(0) : self.view.frame.height
                
                restartButton.isHidden = false
                exitButton.isHidden = false
                restartButton.layer.opacity = 0
                exitButton.layer.opacity = 0
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                    self.restartButton.layer.opacity = 1
                    self.exitButton.layer.opacity = 1
                    if winner {
                        self.redResult.layer.opacity = 1
                    } else {
                        self.blueResult.layer.opacity = 1
                    }
                }, completion: {_ in
                })
                
            }
        }
    }
    
    @IBAction func onRestartClick() {
        if !started && ended {
            fullStart()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
