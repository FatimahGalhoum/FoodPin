//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Fatimah Galhoum on 4/28/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import UIKit
import CoreData



class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var typeTextField:UITextField!
    @IBOutlet var locationTextField:UITextField!
    @IBOutlet var phoneNumberTextField:UITextField!
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    
    var currentVC: UITableView!
    
    
    
    var isVisited : Bool = true
    
    var restaurant:RestaurantMo!
    
    
    
    
    //**************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To make return button on keyboard work
        nameTextField.delegate = self
        typeTextField.delegate = self
        locationTextField.delegate = self
        
        
        
        
        
        //dh 3lshan lma ndos fi ay mkan fady te2fl keyboard el numbers
        func touchesBegan(_ touches: Set<UITouch>,
                          with event: UIEvent?) {
            phoneNumberTextField.resignFirstResponder()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //**************************************************

    
    
    
    
    //**************************************************
    //Load photo from library
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: nil)

                
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    //**************************************************
  
    
    
    
    //**************************************************
    //When user chooses a photo from the photo library this method from delegate called
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoImageView.superview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true

        let trailingConstraint = NSLayoutConstraint(item: photoImageView!,attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoImageView.superview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoImageView.superview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: photoImageView.superview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        bottomConstraint.isActive = true
        
        //dh 3lshan te2fl el library bta3 el pics
        dismiss(animated: true, completion: nil)

    }
    //**************************************************

    
    
    
    
    
    //**************************************************
    //3lshan ama ndos el text field awl haga tstgeb hwa
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //**************************************************

    
    
    
    
    
    
    //**************************************************
    @IBAction func toggleBeenHereButton(sender: UIButton){
        // Yes button clicked
        if sender == yesButton {
            isVisited = true
            
            // Change the backgroundColor property of yesButton to red
            yesButton.backgroundColor = UIColor(red: 216.0/255.0, green: 74.0/255.0, blue: 32.0/255.0, alpha: 1.0)
          
            // Change the backgroundColor property of noButton to gray
            noButton.backgroundColor = UIColor.gray
            
        } else if sender == noButton {
            isVisited = false
           
            // Change the backgroundColor property of yesButton to gray
            yesButton.backgroundColor = UIColor.gray
         
            // Change the backgroundColor property of noButton to red
            noButton.backgroundColor = UIColor(red: 216.0/255.0, green: 74.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        }
    }
    //**************************************************

    
    
    //**************************************************
    @IBAction func savaAction(_ sender: Any) {
        
        // lo 3mlt save w any field empty
        if nameTextField.text == "" || typeTextField.text == "" || locationTextField.text == ""  {
            let alertMessage = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertMessage, animated: true, completion: nil)
            
            return
        }
        print("Name: \(String(describing: nameTextField.text))\n Type: \(String(describing: typeTextField.text))\n Loction: \(String(describing: locationTextField.text))\n Have you been here: \(String(describing: isVisited))\n Phone: \(phoneNumberTextField.text ?? "334224")")
        
        
        //Add data to database
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            restaurant = RestaurantMo(context: appDelegate.persistentContainer.viewContext)
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.location = locationTextField.text
            restaurant.phone = phoneNumberTextField.text
            restaurant.isVisited = isVisited
            
            if let restaurantImage = photoImageView.image {
                if let imageData = restaurantImage.pngData(){
                    restaurant.image = NSData(data: imageData) as Data
                }
            }
            
            print("Saving data to context ...")
            appDelegate.saveContext()
            
        }

        //3lshan t2fl b3d ma ndos save
       dismiss(animated: true, completion: nil)
    }
    //**************************************************

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
