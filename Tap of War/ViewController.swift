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
        UIView.animate(withDuration: 1.4,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 3,
                       animations: {
            self.redImage.frame.size.height = 900
            self.titleLabel.layer.opacity = 0
            self.playButton.layer.opacity = 0
            self.settingsButton.layer.opacity = 0
            self.clickerImage.layer.opacity = 0
        }, completion: {_ in
            self.performSegue(withIdentifier: "PlayingScreen", sender: sender)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var next = segue.destination as! PlayingViewController
    }
    
}

