//
//  SeeAlterationsVC.swift
//  pincushion
//
//  Created by Matt Green on 5/17/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

class SeeAlterationsVC: UITableViewController {
    //MARK:- Properties
    let SectionHeaderHeight: CGFloat = 50
    
    //Applies theme
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = Theme.current.batiste
    }
    
    // MARK:- Show toolbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Select Alteration"

        // you didn't make a contract
        if ContractSingleton.current.uid == "" {
            let alert = createAlert(title: "Please create contract first", message: "", handler: {
                self.navigationController?.popViewController(animated: true)
            })
             self.present(alert, animated: true, completion: nil)
        }
    }
}

// TableView methods
extension SeeAlterationsVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return alterationSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alterationSections[section].alterations.count
    }
    
    //MARK:- Custom header style
    //  https://medium.com/swift-programming/swift-enums-and-uitableview-sections-1806b74b8138
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = Theme.current.lydian_40
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 25)
        let text = alterationSections[section].sectionName
        label.text = " \(text)"
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let alterationSection = alterationSections[indexPath.section]
        cell.backgroundColor = Theme.current.batiste
        cell.textLabel?.text = alterationSection.alterations[indexPath.row].name
        cell.textLabel?.textColor = Theme.current.essence
        return cell
    }
}

// ShowAddAlterationVC
//MARK:- Segue
extension SeeAlterationsVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowAddAlterationVC"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let section = tableView.indexPathForSelectedRow!.section
                // Get the item associated with this row and pass it along
                let destinationVC = segue.destination as! AddAlterationVC
                
                // AlterationType object reference... pass it on
                let object = alterationSections[section].alterations[row]
                destinationVC.object = object

            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
}


