//
//  AddHabitViewController.swift
//  Habit Track
//
//  Created by Jonathan Chen on 4/12/21.
//

import UIKit

protocol AddHabitDelegate: class {
    func didCreate(_ habit: Habit)
}

class AddHabitViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var emoji: UITextField!
    @IBOutlet weak var desc: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: AddHabitDelegate?
    
    @IBAction func saveHabit(_ sender: Any) {
        let newHabit: Habit? = createNewHabit()
        
        // habit validation
        if newHabit != nil {
            self.delegate?.didCreate(newHabit!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelHabit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func createNewHabit() -> Habit? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        
        if name.text!.isEmpty || emoji.text!.isEmpty || desc.text!.isEmpty || dateString.isEmpty {
            return nil
        }
        
        return Habit(name: name.text!.capitalized, startDate: dateString, emoji: emoji.text!, description: desc.text!)
    }


}
