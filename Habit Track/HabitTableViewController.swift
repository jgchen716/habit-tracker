//
//  HabitTableViewController.swift
//  Habit Track
//
//  Created by Jonathan Chen on 4/12/21.
//

import UIKit

class HabitTableViewController: UITableViewController, AddHabitDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var habits: [Habit] = []
    
    // filtered search results
    var filtered: [Habit] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // search bar methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!.lowercased()
        let currentResults = habits.filter { h in
            return h.name.lowercased().contains(text) || h.description.lowercased().contains(text) ||
                h.emoji.lowercased().contains(text) || h.startDate.lowercased().contains(text)
        }
        filtered = currentResults
        self.isSearching = true
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.isSearching = false
            self.tableView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            self.isSearching = false
            self.tableView.reloadData()
        }
    }
    
    // adding habit, sorting list of habits
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
    
    // table view methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filtered.count : habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath)
        
        let habit = isSearching ? filtered[indexPath.row] : habits[indexPath.row]
        
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
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "HabitToDetail", sender: habits[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                habits.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
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
