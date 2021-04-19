//
//  StartViewController.swift
//  Habit Track
//
//  Created by Jonathan Chen on 4/12/21.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBAction func goToHabit(_ sender: Any) {
        performSegue(withIdentifier: "StartToHabit", sender: Any?.self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImage.image = UIImage(named: "rocket")
    }


}
