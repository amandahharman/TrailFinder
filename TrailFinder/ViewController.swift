//
//  ViewController.swift
//  TrailFinder
//
//  Created by Amanda Harman on 6/3/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let trail1 = Trail(name: "Hawthorn", parkName: "Gainesville", description: "A good one")
    let trail2 = Trail(name: "Amanda's Trail", parkName: "Panda Forest", description: "This one's for PB")
    
    var trails = [Trail]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        trails += [trail1, trail2]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trailCell") as! TrailTableViewCell
    
        cell.titleLabel.text = trails[indexPath.row].name
        cell.descriptionLabel.text = trails[indexPath.row].description
        cell.parkLabel.text = trails[indexPath.row].parkName
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trails.count
    }

}

