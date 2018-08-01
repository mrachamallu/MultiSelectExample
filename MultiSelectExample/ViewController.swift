//
//  ViewController.swift
//  MultiSelectExample
//
//  Created by Meera Rachamallu on 7/31/18.
//  Copyright © 2018 Meera Rachamallu. All rights reserved.
//

import UIKit

private let SectionVegetables = 0
private let SectionDesserts = 1
private let NumberOfSections = 2

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var vegetables = ["carrots", "broccoli", "cauliflower"]
    var desserts = ["pumpkin pie", "cake", "brownies"]
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "food"


        view.addSubview(tableView)
        tableView.allowsMultipleSelectionDuringEditing = true

        //constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        
        //toolbar setup
        self.navigationController?.setToolbarHidden(false, animated: false)
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(didPressDelete))
        self.toolbarItems = [flexible, deleteButton]
        self.navigationController?.toolbar.barTintColor = UIColor.white

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        //edit feature
        self.navigationItem.rightBarButtonItem = editButtonItem
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return NumberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == SectionVegetables {
                assert(section == SectionVegetables)
                return vegetables.count
            } else {
                assert(section == SectionDesserts)
                return desserts.count
            }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            if indexPath.section == SectionVegetables {
                assert(indexPath.section == SectionVegetables)
                cell.textLabel?.text = vegetables[indexPath.item]
            }
            if indexPath.section == SectionDesserts {
                assert(indexPath.section == SectionDesserts)
                cell.textLabel?.text = desserts[indexPath.item]
            }
            return cell
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == SectionVegetables && tableView.isEditing {
            return true
        }
        return false
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section == SectionVegetables else { return false }
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            vegetables.remove(at: indexPath.item)
            tableView.reloadData()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        tableView.setEditing(editing, animated: true)
    }

    @objc func didPressDelete() {
        let selectedRows = self.tableView.indexPathsForSelectedRows
        if selectedRows != nil {
            for var selectionIndex in selectedRows! {
                while selectionIndex.item >= vegetables.count {
                    selectionIndex.item -= 1
                }
                tableView(tableView, commit: .delete, forRowAt: selectionIndex)
            }
        }
    }

}

