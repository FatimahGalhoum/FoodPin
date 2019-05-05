//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Fatimah Galhoum on 4/19/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import UIKit
import MapKit


class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var restaurantImageView : UIImageView!
    //@IBOutlet var nameLabel : UILabel!
    //@IBOutlet var locationLabel : UILabel!
    //@IBOutlet var typeLabel : UILabel!
    @IBOutlet var tableView:UITableView!
    @IBOutlet var mapView: MKMapView!
    
    
    
    var restaurant:RestaurantMo!

    
    
    //**************************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of rows
        return 5
    }
    //**************************************************

    
    //**************************************************
    // dh el hagat elee hatt3rd fe el cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RestaurantDetailTableViewCell
        
        //configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phone
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before \(restaurant.rating ?? "good")" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        //3lshan the color of the sell the default is white to add your custom color you have to add this line
        cell.backgroundColor = UIColor.clear

        return cell
        
    }
    
    //**************************************************



    
    //**************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To show image
        restaurantImageView.image = UIImage(data: restaurant.image ?? Data())
        
        //The color of the cell
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)

        //delete the bottom code to show map
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        title = restaurant.name
        
        //Self Sizing Cells
        tableView.estimatedRowHeight = 36.0 //default size
        tableView.rowHeight = UITableView.automaticDimension
        
        //3lshan el navigation bar elle fo2 mtro74
        navigationController?.hidesBarsOnSwipe = false
        
        //3lshan lma ndos 2la el map tn2nly l view controller tany 3n tari2 segue
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        //Adding an Annotation to the Non-interactive Map & Pin the restaurant location on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location!, completionHandler: { placemarks, error in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let placemarks = placemarks {
                
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    
                    // Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    // Set the zoom level
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
        
       // nameLabel.text = restaurant.name
    //    locationLabel.text = restaurant.location
    //    typeLabel.text = restaurant.type
        
    }
    //**************************************************

    
    
    //**************************************************
    //3lshan lma ndos 2la el map tn2nly l view controller tany 3n tari2 segue
    @objc func showMap(){
        performSegue(withIdentifier: "showMap", sender: self)
    }
    //**************************************************

    
    //**************************************************
    //3lshan amn3 en al navigation bar enha mt5tfe4
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //**************************************************

    
    //**************************************************
    //Unwind Segues
    @IBAction func close(segue:UIStoryboardSegue) {
        
    }
    //**************************************************

    
    
    
    //**************************************************
    //Unwind Segues and Data Passing
    @IBAction func ratingButtonTapped(segue : UIStoryboardSegue){
        
        if let rating = segue.identifier {
            restaurant.isVisited = true
            
            switch rating {
            case "great": restaurant.rating = "Absolutely love it! Must try."
            case "good": restaurant.rating = "Pretty good."
            case "dislike": restaurant.rating = "I don't like it."
            default: break
            }
            
        }
        //3lshan thfz el rating fe database
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) { appDelegate.saveContext()
            
        }
        
        tableView.reloadData()
    }
    //**************************************************

    
    //**************************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview" {
                let destinationController = segue.destination as! ReviewViewController
                destinationController.restaurant = restaurant
            }
        
        else if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
        }
        }
    //**************************************************

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
