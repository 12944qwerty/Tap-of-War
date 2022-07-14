//
//  PlayingViewController.swift
//  Tap of War
//
//  Created by DPI Student 47 on 7/12/22.
//

import UIKit

let SPEED = 5

class PlayingViewController: UIViewController {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var middle: CGFloat!
    var middleWidth: CGFloat!
    @IBOutlet weak var countdownLabel: UILabel!
    var started: Bool = false
    
    var blueTapCount: Int = 0
    var redTapCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        middle = view.frame.height / 2
        middleWidth = view.frame.width / 2
//        heightConstraint.constant = 0
//
//        UIView.animate(withDuration: 1.5,
//            delay: 0,
//            usingSpringWithDamping: 0.6,
//            initialSpringVelocity: 1,
//            animations: {
//            self.heightConstraint.constant = self.view.frame.height / 2
//            self.view.layoutIfNeeded()
//            },
//            completion: countdown
//        )
        heightConstraint.constant = middle
        view.layoutIfNeeded()
        countdown()
    }
    
    func countdown() {
//        countdownLabel.center.y = middle
        
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
        if started {
            if sender.view == self.view {
                blueTapCount += 1
            } else {
                redTapCount += 1
            }
            heightConstraint.constant = middle + CGFloat((blueTapCount - redTapCount) * (Int(self.view.frame.height) / 100))
            UIView.animate(withDuration: 0.1, animations: {
                self.view.layoutIfNeeded()
            })
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
