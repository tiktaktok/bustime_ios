//
//  DepartureTimesScrollViewController.swift
//  BusTime
//
//  Created by Mathieu Clement on 10/17/15.
//  Copyright © 2015 Mathieu Clement. All rights reserved.
//

import UIKit

class DepartureTimesTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var connections = [Connection]()
    var connectionsByTripShortName = OrderedDictionary<String, [Connection]>()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        initTV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initTV()
    }
    
    private func initTV() {
        self.delegate = self
        self.dataSource = self
    }
    
    func setConnections(connections: [Connection]) {
        self.connections = connections
        self.connectionsByTripShortName = Connection.groupByTripShortName(connections)
        reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section)
    }
    
    override func numberOfRowsInSection(section: Int) -> Int {
        let tripName = connectionsByTripShortName.keys[section]
        return (connectionsByTripShortName[tripName]?.count)!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return connectionsByTripShortName.keys[section]
    }
    
    
    /*
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
    }
    */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellForRowAtIndexPath(indexPath)!
    }
    
    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        var cell = dequeueReusableCellWithIdentifier("departureTimeTableCell") as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                reuseIdentifier: "departureTimeTableCell")
        }
        
        let tripIndex = indexPath.section
        let tripShortName = connectionsByTripShortName.keys[tripIndex]
        let connectionIndex = indexPath.row
        let connectionsForTrip = connectionsByTripShortName[tripShortName]
        let connection = connectionsForTrip![connectionIndex]
        let nbMin = minutesFromNow(connection.departure)
        
        cell?.textLabel!.text = connection.tripHeadSign
        if nbMin < 61 {
            cell?.detailTextLabel!.text = "\(nbMin) min"
        } else {
            
        }
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return connectionsByTripShortName.keys.count
    }
    
}