//
//  PrimaryVC.swift
//  Upsilon
//
//  Created by Pavel Seleznev on 5/16/19.
//  Copyright © 2019 Pavel Seleznev. All rights reserved.
//

import UIKit

class PrimaryVC: UIViewController {
    
    var refuelAmount: [String] = []

    @IBOutlet weak var tableView: UITableView!
    
    // Implement the addRefuel IBAction
    @IBAction func addRefuel(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Refuel", message: "Add a refuel", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let refuelToSave = textField.text else {
                    return
            }
            
            self.refuelAmount.append(refuelToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Заправки"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

 // MARK: - UITableViewDataSource

extension PrimaryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refuelAmount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = refuelAmount[indexPath.row]
        return cell
    }
}
