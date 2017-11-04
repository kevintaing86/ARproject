//
//  openCapsuleViewController.swift
//  AR-App
//
//  Created by Kevin Taing on 11/4/17.
//  Copyright © 2017 Kevin Taing. All rights reserved.
//

import UIKit

class openCapsuleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var popoverView: UIView!
    @IBOutlet weak var capsuleName: UILabel!
    @IBOutlet weak var addNameButtom: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var listOfNames = ["John Smith", "Jane Doe"] // will replace with actual names once DB is setup
    
    @IBAction func addName(_ sender: Any) {
        self.view.addSubview(popoverView)
        popoverView.center = self.view.center
        
        popoverView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popoverView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.popoverView.alpha = 1
            self.popoverView.transform = CGAffineTransform.identity
        }
    }
    @IBAction func saveName(_ sender: Any) {
        var name: String
        if let name = nameField.text {
            listOfNames.append(name)
            self.tableView.reloadData()
        }
        
        dismissModal()
    }
    @IBAction func closePopover(_ sender: Any) {
        dismissModal()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = listOfNames[indexPath.row]
        
        return cell
    }
    
    func dismissModal() {
        UIView.animate(withDuration: 0.2, animations: {
            self.popoverView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popoverView.alpha = 1
        }) { ( success: Bool ) in
            self.popoverView.removeFromSuperview()
        }
    }
}
