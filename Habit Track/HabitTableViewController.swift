//
//  HabitTableViewController.swift
//  Habit Track
//
//  Created by Jonathan Chen on 4/12/21.
//

import UIKit

class HabitTableViewController: UITableViewController {

    @IBAction func addHabit(_ sender: Any) {
        performSegue(withIdentifier: "HabitToAdd", sender: Any?.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
