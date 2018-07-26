//
//  MapViewController.swift
//  Memorable Places
//
//  Created by Hamada on 6/5/18.
//  Copyright © 2018 Hamada. All rights reserved.
//

import UIKit
var places = [Dictionary<String,String>()]
var activePlaces = -1
class PlacesViewController:UITableViewController {
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // viewDidLoad not always run when view is appear
    //viewDidAppear always run when view is appear
    override func viewDidAppear(_ animated: Bool) {
        if let temPlace = UserDefaults.standard.object(forKey: "place") as? [Dictionary<String,String>]{
            places = temPlace
        }
        if places.count == 1 && places[0].count == 0 {
            places.remove(at: 0)
            places.append(["name":"Taj Mahal" , "lat" : "27.175277" , "lon" : "78.042128"])
        }
        activePlaces = -1
        UserDefaults.standard.set(places, forKey: "place")
        table.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        if places[indexPath.row]["name"] != nil
        {
        cell.textLabel?.text = places[indexPath.row]["name"]
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activePlaces = indexPath.row
        performSegue(withIdentifier: "toMap2", sender: nil)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            places.remove(at: indexPath.row)
            UserDefaults.standard.set(places, forKey: "place")
            table.reloadData()
        }
    }
   
  
   
    

  
}
