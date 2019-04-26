//
//  ViewController.swift
//  Upsilon
//
//  Created by Pavel Seleznev on 4/25/19.
//  Copyright © 2019 Pavel Seleznev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: Outlets & Actions
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addRefuel(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New refuel", message: "Add a new refuel", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let refuelToSave = textField.text else {
                    return
            }
            
            self.save(fuelAmount: refuelToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(fuelAmount: String?) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Vehicle", in: managedContext)!
        
        let vehicle = NSManagedObject(entity: entity, insertInto: managedContext)
        
        vehicle.setValue(fuelAmount, forKeyPath: "fuelAmount")
        
        do {
            try managedContext.save()
            vehicles.append(vehicle)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    var vehicles: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vehicle = vehicles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: [indexPath.row])
        cell.textLabel?.text = vehicle.value(forKeyPath: "fuelAmount") as? String
        return cell
    }
}
