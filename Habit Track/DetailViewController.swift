//
//  DetailViewController.swift
//  Habit Track
//
//  Created by Jonathan Chen on 4/12/21.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var habitName: UILabel!
    @IBOutlet weak var habitDesc: UILabel!
    @IBOutlet weak var numDays: UILabel!
    @IBOutlet weak var streak: UILabel!
    
    var habit: Habit?
    var dates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emoji.text = "\(habit!.emoji)"
        habitName.text = "\(habit!.name)"
        habitDesc.text = "\(habit!.description)"
        numDays.text = "Total Days: \(habit!.numDays)"
        streak.text = "\(habit!.streak) Day Streak!"
    }

    // stepper
    
    func getDateString(date: Date) -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    @IBAction func step(_ sender: UIStepper) {
        let val = Int(sender.value)
        
        if val >= 0 {
            let current = Date()
            let currentDateString = getDateString(date: current)
            
            // check if last day tracked was previous day
            var dateComponents = DateComponents()
            dateComponents.month = 0
            dateComponents.day = -1
            dateComponents.year = 0
            
            let oldDate = Calendar.current.date(byAdding: dateComponents, to: current)!
            let oldDateString = getDateString(date: oldDate)
            
            if dates.count == 0 {
                numDays.text = "Total Days: \(val)"
                
                let newVal = habit!.streak + 1
                habit!.streak = newVal
                streak.text = "\(newVal) Day Streak!"
                // add new date to days tracked
                dates.insert(currentDateString, at: 0)
            } else {
                       
                // increase total days if current day is not the same as last day tracked
                if currentDateString != dates[0] {
                    numDays.text = "Total Days: \(val)"
                    // add new date to days tracked
                    dates.insert(currentDateString, at: 0)
                }
                
                // increase streak if last tracked date was yesterday
                if oldDateString == dates[0] {
                    let newVal = habit!.streak + 1
                    habit!.streak = newVal
                    streak.text = "\(newVal) Day Streak!"
                    
                    if newVal >= 10 {
                        streak.backgroundColor = UIColor.green
                    }
                }
            }      
            self.tableView.reloadData()
        }
        
    }
    
    // table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath)
        
        cell.textLabel!.text = dates[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                dates.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
}
