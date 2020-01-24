//
//  GigsTableViewController.swift
//  Gigs
//
//  Created by alfredo on 1/20/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class GigsTableViewController: UITableViewController {
    
    //MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        //Verify that user is sign in
        if gigController.bearer == nil{
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    //MARK: - Properties
    
    let gigController = GigController()
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gigController.gigs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let row = indexPath.row
        let gig = gigController.gigs[row]

        cell.gig = gig
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue"{
            //Dependency Injection (send gig controller to next view)
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.gigController = gigController
            }
        }
    }
}
