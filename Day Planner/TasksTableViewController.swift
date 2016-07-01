//
//  TasksTableViewController.swift
//  Day Planner
//
//  Created by Roman on 1/13/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController, NSFetchedResultsController, NSFetchedResultsControllerDelegate
{
    var appDel: AppDelegate = AppDelegate()
    var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)

    override func viewDidLoad()
    {
        super.viewDidLoad()

        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    // Mark: - Fetched Results Controller
    var _fetchedResultsController: NSFetchedResultsController? = nil

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }

        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Tasks", inManagedObjectContext: self.context)
        fetchRequest.entity = entity

        fetchRequest.fetchBatchSize = 20

        let sortDescriptor = NSSortDescriptor(key: "taskDateStamp", ascending: false)

        fetchRequest.sortDescriptors = [sortDescriptor]

        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: "taskDate", cacheName: nil)

        aFetchedResultsController.delegate = self

        _fetchedResultsController = aFetchedResultsController

        do {
            try _fetchedResultsController!.performFetch()
        } catch _ {
            abort()
        }
        return _fetchedResultsController!
    }

    func controllerWillChangeContent(controller: NSFetchedResultsController)
    {
        self.tableView.beginUpdates()
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {

        switch type
        {
        case.Insert:
            self.tableView.insertSections(NSIndexSet(indexSet: sectionIndex), withRowAnimation: .Fade)

        case.Delete:
            self.tableView
        }
    }
}
