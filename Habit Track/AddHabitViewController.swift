//
//  AddHabitViewController.swift
//  Habit Track
//
//  Created by Jonathan Chen on 4/12/21.
//

import UIKit

class AddHabitViewController: UIViewController {

    @IBAction func saveHabit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelHabit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
