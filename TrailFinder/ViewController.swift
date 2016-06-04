//
//  ViewController.swift
//  TrailFinder
//
//  Created by Amanda Harman on 6/3/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
  
    var trails = [Trail]()
    var arrRes = [[String:AnyObject]]()
    var parks = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self

        
        Alamofire.request(.GET, "https://api.transitandtrails.org/api/v1/trailheads?key=94669896c38b621d84dcb8351048a6741afb9370b09f8a6809708102e102cec2&limit=20")
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error calling GET on /api/v1/trailheads")
                    print(response.result.error!)
                    return
                }
                if let value = response.result.value {
                    print(value)
                    if let resData = JSON(value).arrayObject{
                        self.arrRes = resData as! [[String:AnyObject]]
                    }
                    if self.arrRes.count > 0 {
                        for trailDictionary in self.arrRes {
                            self.trails.append(Trail(name: (trailDictionary["name"] as? String)!, parkName: (trailDictionary["park_name"] as? String)!))
                            self.parks.append((trailDictionary["park_name"] as? String)!)
                        }
                    self.tableView.reloadData()
                    }
                }
        }
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trailCell") as! TrailTableViewCell
        cell.titleLabel.text = trails[indexPath.row].name
        cell.parkLabel.text = trails[indexPath.row].parkName
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trails.count

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return parks.count
    }

}

