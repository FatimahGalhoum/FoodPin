//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Fatimah Galhoum on 4/26/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var backgroundImage : UIImageView!
    
    
    var restaurant: RestaurantMo!
  
    //el if dh fe halet ana m4 mot2kdh feh sora ao l2 3lashn el app my3ml4 crash
    //var restaurant: Restaurant?
    

    
    //**************************************************
    override func viewDidLoad() {
        super.viewDidLoad()

      
        //el if dh fe halet ana m4 mot2kdh feh sora ao l2 3lashn el app my3ml4 crash
        //if let restaurant = restaurant {
        backgroundImage.image = UIImage(data: restaurant.image ?? Data())
     //   }
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
       // Growing animation and Spring Animation
        containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
        
        //Slide-Down Animation
        //containerView.transform = CGAffineTransform.init(translationX: 0, y: -1000)
        
        
        //Combining Two Transforms
        /*
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
        */
        
    }
    //**************************************************

    
    
    //**************************************************

    //Growing animation
    override func viewDidAppear(_ animated: Bool) {
      
        //Growing animation and Slide-down Animation and Combining Two Transforms

        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform.identity
            
        })
 
     /*
        //Spring animation
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: { self.containerView.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
        */
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
