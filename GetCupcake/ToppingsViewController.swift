//
//  ToppingsViewController.swift
//  GetCupcake
//
//  Created by Viktor Yamchinov on 10/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import UIKit

class ToppingsViewController: UITableViewController {
    
    var cake: Product!
    var toppings = [Product]()
    var selectedToppings = Set<Product>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Add Toppings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Place Order", style: .plain, target: self, action: #selector(placeOrder))
        guard let url = Bundle.main.url(forResource: "toppings", withExtension: "json") else {
            fatalError("Can't find toppings json in app bundle")
        }
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            toppings = (try? decoder.decode([Product].self, from: data)) ?? [Product]()
            toppings.sort {
                return $0.name < $1.name
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toppings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let topping = toppings[indexPath.row]
        cell.textLabel?.text = "\(topping.name) - $\(topping.price)"
        cell.detailTextLabel?.text = topping.description
        if selectedToppings.contains(topping) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // pull out the cell that was tapped
        guard let cell = tableView.cellForRow(at: indexPath) else {
            fatalError("Unable find cell that was tapped")
        }
        let topping = toppings[indexPath.row]
        if cell.accessoryType == .checkmark {
            // this was checked - unchek it
            cell.accessoryType = .none
            selectedToppings.remove(topping)
        } else {
            // this wasn't checked - so check it
            cell.accessoryType = .checkmark
            selectedToppings.insert(topping)
        }
        // remove the highlight for this cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func placeOrder() {
        guard let orderViewController = storyboard?.instantiateViewController(withIdentifier: "OrderViewController") as? OrderViewController else {
            fatalError("Unable to load OrderViewController from storyboard")
        }
        orderViewController.cake = cake
        orderViewController.toppings = selectedToppings
        navigationController?.pushViewController(orderViewController, animated: true)
    }

}
