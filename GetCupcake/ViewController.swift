//
//  ViewController.swift
//  GetCupcake
//
//  Created by Viktor Yamchinov on 10/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Cupcake Country"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu.shared.cakes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cake = Menu.shared.cakes[indexPath.row]
        cell.textLabel?.text = "\(cake.name) - $\(cake.price)"
        cell.detailTextLabel?.text = cake.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let toppingsViewController = storyboard?.instantiateViewController(withIdentifier: "ToppingsViewController") as? ToppingsViewController else {
            fatalError("Unable to load ToppingsViewController from storyboard")
        }
        toppingsViewController.cake = Menu.shared.cakes[indexPath.row]
        navigationController?.pushViewController(toppingsViewController, animated: true)
    }

}

