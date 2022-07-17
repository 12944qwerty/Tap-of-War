//
//  ViewController.swift
//  Tap of War
//
//  Created by DPI Student 47 on 7/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var redImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var clickerImage: UIImageView!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func onPlayClick(_ sender: Any) {
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       animations: {
//            self.redImage.frame.size.height = 900
            self.titleLabel.layer.opacity = 0
            self.playButton.layer.opacity = 0
            self.settingsButton.layer.opacity = 0
            self.clickerImage.layer.opacity = 0
        }, completion: {_ in
            self.performSegue(withIdentifier: "PlayingScreen", sender: sender)
        })
    }
    
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue

        self.titleLabel.layer.opacity = 1
        self.playButton.layer.opacity = 1
        self.settingsButton.layer.opacity = 1
        self.clickerImage.layer.opacity = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var next = segue.destination as! PlayingViewController
    }
    
}

