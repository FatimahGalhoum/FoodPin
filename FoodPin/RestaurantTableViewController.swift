//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Fatimah Galhoum on 4/17/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import UIKit
import CoreData


class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {


//    //3lshan mi3mlsh mark 3la cell tania because of reused cell
//    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    
    var restaurants:[RestaurantMo] = []
    var fetchResultController : NSFetchedResultsController<RestaurantMo>!
    
    var searchController:UISearchController!
    var searchResults:[RestaurantMo] = []
    
    
/*
    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F,72 Po Hing Fong, Sheung Wan, Hong Kong", image: "cafedeadend.jpg", phone: "232-923423", isVisited: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", image: "homei.jpg", phone: "348-233423", isVisited: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "teakha.jpg", phone: "354-243523", isVisited: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "cafeloisl.jpg", phone: "453333423", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "petiteoyster.jpg", phone: "983-284334", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop JK., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", image: "forkeerestaurant.jpg", phone: "232-434222", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", image: "posatelier.jpg", phone: "234-834322", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", image: "bourkestreetbakery.jpg", phone: "982-434343", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", image: "haighschocolate.jpg", phone: "734-232323", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", image: "palominoespresso.jpg", phone: "872-734343", isVisited: false),
        Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", image: "upstate.jpg", phone: "343-233221", isVisited: false),
        Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", image: "traif.jpg", phone: "985-723623", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", image: "grahamavenuemeats.jpg", phone: "455-232345", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", image: "wafflewolf.jpg", phone: "434-232322", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", image: "fiveleaves.jpg", phone: "343-234553", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", image: "cafelore.jpg", phone: "342-455433", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", image: "confessional.jpg", phone: "643-332323", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", image: "barrafina.jpg", phone: "542-343434", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", image: "donostia.jpg", phone: "722-232323", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", image: "royaloak.jpg", phone: "343-988834", isVisited: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", image: "caskpubkitchen.jpg", phone: "432-344050", isVisited: false)]
 */
    
    
    //**************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        //3l4an zorar el back yb2a m3lho4 klam
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        //Self Sizing Cells
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        
        //To hide navigation bar
        navigationController?.hidesBarsOnSwipe = true
        
        
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<RestaurantMo> = RestaurantMo.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
        
        //Search bar
        searchController = UISearchController(searchResultsController: nil) //dh m3naha 3l3 el result fe nfs el page
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        
        
        
 
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //**************************************************

    
    
    
    
    
    
    
    
    //**************************************************
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true

    }
    //**************************************************
    
    
    
    
    //**************************************************
    // 3lshan tzhrly shasht el t3lemat elle fe el 2ol
    override func viewDidAppear(_ animated: Bool) {
        
        /*
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? WalkthroughPageViewController {
        
        present(pageViewController, animated: true, completion: nil)
        
        }
        */
        
        
        //Walkthrough screen to make it work once
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
            
        }
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? WalkthroughPageViewController  {
            
            present(pageViewController, animated: true, completion: nil)
            
        }
        
    }
    //**************************************************

    
    
    
    
    
    
    
    //**************************************************
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //3lshan nfr2 eh el m3rod ntegt el search wl data nfsha
        if searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
            
        }
    }
    
    //**************************************************
    
    
    
    
    //**************************************************
    // dh elle bnzhr feha elklam wl pics
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Determine if we get the restaurant from search result or the original array
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image ?? Data())
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        
        
        /*
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(data: restaurants[indexPath.row].image as! Data)
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
 
 
        
        //3lshan mi3mlsh mark 3la cell tania because of reused cell
        if restaurants[indexPath.row].isVisited {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        //OR shorted way
        //cell.accessoryType = restaurants[indexPath.row].isVisited ? .checkmark : .none
 */
        
        return cell
    }
    //**************************************************

    
    
    
    //**************************************************
    // dh elle hi7sl lma el user y5tar row from table view
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: UIAlertController.Style.actionSheet)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        //CLOSURE
//        let callActionHandler = { (action:UIAlertAction!) -> Void in
//            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. please retry later.", preferredStyle: .alert)
//            alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(alertMessage, animated: true, completion: nil)
//        }
//
//
//        let callAction = UIAlertAction(title: "Call + 123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
//        optionMenu.addAction(callAction)
//        optionMenu.addAction(cancelAction)
//        present(optionMenu, animated: true, completion: nil)
//
//
//        let checkInTitle = restaurantIsVisited[indexPath.row] ? "Undo Check In" : "Check In"
//        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler: {  (action:UIAlertAction!) -> Void in
//
//            let cell = tableView.cellForRow(at: indexPath)
//            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
//            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
//            //3lshan mi3mlsh mark 3la cell tania because of reused cell
//
//
//        })
//
//        optionMenu.addAction(checkInAction)
//
//        // when you select a row, the row is highlighted in gray and stayed as selected. Add the following code at the end of the tableView(_:didSelectRowAt:) method to deselect the row
//        tableView.deselectRow(at: indexPath, animated: false)
//        //Or this long way
//
//        //check in action
////        if restaurantIsVisited[indexPath.row] == false {
////        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {  (action:UIAlertAction!) -> Void in
////
////            let cell = tableView.cellForRow(at: indexPath)
////            cell?.accessoryType = .checkmark
////            //3lshan mi3mlsh mark 3la cell tania because of reused cell
////            self.restaurantIsVisited[indexPath.row] = true
////
////        })
////        optionMenu.addAction(checkInAction)
////        } else {
////
////            let UndoCheckInAction = UIAlertAction(title: "Undo Check in", style: .default, handler: {  (action:UIAlertAction!) -> Void in
////
////                let cell = tableView.cellForRow(at: indexPath)
////                cell?.accessoryType = .none
////                //3lshan mi3mlsh mark 3la cell tania because of reused cell
////                self.restaurantIsVisited[indexPath.row] = false
////
////            })
////            optionMenu.addAction(UndoCheckInAction)
////
////        }
////
//
//
//
//    }
//
    //**************************************************


    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        //7atina dh hena 3lshan lma n3ml search ne2fl 7aset el share wel delete
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    //**************************************************
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            restaurants.remove(at: indexPath.row)
        }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        
        //tableView.reloadData()
        print("Total item: \(restaurants.count)")
        for name in restaurants {
            print(name)
        
        }}
    //**************************************************

    
    

    //**************************************************
    //Swipe for More Actions Using UITableViewRowAction
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Social Sharing Button
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: {(action,indexPath) -> Void in
            
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image ?? Data()){
            let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            self.present(activityController,animated: true,completion: nil)
            }
        })
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(action, indexPath) -> Void in
            
            //delete the row for data source
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                appDelegate.saveContext()
                
            }
 
//            self.restaurants.remove(at: indexPath.row)
//
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        })
        
        
        //color of share and action button
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        
        
        return[deleteAction, shareAction]
    }
    
    //**************************************************

    
    
    
    
    //**************************************************
    //Insert data
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
                
            }
        default:
            tableView.reloadData() }
        
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMo]
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        
    }
    //**************************************************

    
    
    //**************************************************
    //filter data search bar
    func filterContent(for searchText:String){
        searchResults = restaurants.filter({(restaurants) -> Bool in
            if let name = restaurants.name, let location = restaurants.location {
                let isMatch = name.localizedCaseInsensitiveContains(searchText) || location.localizedCaseInsensitiveContains(searchText)
          
                return isMatch
            }
            
            return false
        })
    }

    //**************************************************

    
    
    //**************************************************
    //Updating Search Results 3lshan tzhr el result
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    //**************************************************
    
    

    
    //**************************************************
    //dh method 3lshan tn2lne ll view controller el tany
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    
    //**************************************************
    //dh 3lshan trg3ny ll home
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
        
    }
    //**************************************************

    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

