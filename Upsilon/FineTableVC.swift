//
//  FineTableVC.swift
//  Upsilon
//
//  Created by Pavel Seleznev on 5/13/19.
//  Copyright © 2019 Pavel Seleznev. All rights reserved.
//

import UIKit

class FineTableVC: UITableViewController {
    
    var fines = [Fine]()
    var filteredFines = [Fine]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        fines = [
            Fine(fineDescription: "Пьяная езда", fineAmount: "30 000₽ с лишением прав от 1.5 до 2 лет."),
            Fine(fineDescription: "Превышение скорости", fineAmount: "От 500 До 5000₽, лишение водительских прав на 6 мес (зависит от нарушения скоростного режима)."),
            Fine(fineDescription: "Езда без прав", fineAmount: "От 5 000 до 15 000₽, отстранение от управления ТС, задержание ТС."),
            Fine(fineDescription: "Отсутствие деского кресла", fineAmount: "От 5 000 до 15 000₽, отстранение от управления ТС, задержание ТС."),
            Fine(fineDescription: "Разговор по телефону", fineAmount: "Предупреждение или штраф 500₽."),
            Fine(fineDescription: "Брызговики", fineAmount: "Предупреждение или штраф 500₽."),
            Fine(fineDescription: "Отсутствие аптечки", fineAmount: "Предупреждение или штраф 500₽ руб."),
            Fine(fineDescription: "Несоблюдение дистанции", fineAmount: "1500₽."),
            Fine(fineDescription: "Отсутствие деского кресла", fineAmount: "От 5 000 до 15 000 ₽, отстранение от управления ТС, задержание ТС.")
        ]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredFines = fines.filter({( fine: Fine) -> Bool in
            return fine.fineDescription.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredFines.count
        }
        
        return fines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FineCell", for: indexPath)
        let fine: Fine
        if isFiltering() {
            fine = filteredFines[indexPath.row]
        } else {
            fine = fines[indexPath.row]
        }
        cell.textLabel!.text = fine.fineDescription
        cell.detailTextLabel!.text = fine.fineAmount
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FineTableVC: UISearchResultsUpdating {
    // MAKR: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
