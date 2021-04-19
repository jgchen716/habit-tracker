//
//  HabitTableViewController.swift
//  Habit Track
//
//  Created by Jonathan Chen on 4/12/21.
//

import UIKit

class HabitTableViewController: UITableViewController, AddHabitDelegate {
    
    var habits: [Habit] = []
    
    func didCreate(_ habit: Habit) {
        dismiss(animated: true, completion: nil)
        habits.append(habit)
        
        habits.sort{ (habit1, habit2) -> Bool in
            habit1.startDate < habit2.startDate
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func addHabit(_ sender: Any) {
        performSegue(withIdentifier: "HabitToAdd", sender: Any?.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath)
        
        let habit = habits[indexPath.row]
        
        if let name = cell.viewWithTag(1) as? UILabel {
            name.text = habit.name
        }
        
        if let desc = cell.viewWithTag(2) as? UILabel {
            desc.text = habit.description
        }
        
        if let emoji = cell.viewWithTag(3) as? UILabel {
            emoji.text = habit.emoji
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "HabitToDetail", sender: habits[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HabitToDetail" {
            if let habitInfo = sender as? Habit {
                if let detailVC = segue.destination as? DetailViewController {
                    detailVC.habit = habitInfo
                }
            }
        } else if segue.identifier == "HabitToAdd" {
            if let navVC = segue.destination as? UINavigationController {
                if let addVC = navVC.topViewController as? AddHabitViewController {
                    addVC.delegate = self
                }
            }
        }
    }
}
