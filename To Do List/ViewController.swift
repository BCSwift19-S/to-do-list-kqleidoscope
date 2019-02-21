//
//  ViewController.swift
//  To Do List
//
//  Created by Hiroki on 2019/02/10.
//  Copyright © 2019 Hiroki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var toDoArray = ["Learn Swift", "Build Apps", "Change the World"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//table view will send messages to view controller
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let destination = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }

    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue) {
        let sourceViewCOntroller = segue.source as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            toDoArray[indexPath.row] = sourceViewCOntroller.toDoItem!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            // if there is nothing in the row, create new row
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewCOntroller.toDoItem!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
}
