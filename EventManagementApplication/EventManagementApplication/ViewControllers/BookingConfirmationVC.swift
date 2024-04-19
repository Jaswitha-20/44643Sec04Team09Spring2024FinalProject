//
//  BookingConfirmationVC.swift
//  EventManagementApplication
//
//  Created by Jaswitha Kalikiri on 3/21/24.
//

import UIKit
import AnimatedGradientView

class BookingConfirmationVC: UIViewController {

    var eventDetails: String = "Event details to share"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
                animatedGradient.direction = .up
                animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                                    (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                                    (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                                    (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
                view.addSubview(animatedGradient)
                view.sendSubviewToBack(animatedGradient)
    }
    
    
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        
        // Create an activity view controller with the event details
                let activityViewController = UIActivityViewController(activityItems: [eventDetails], applicationActivities: nil)
                // Present the activity view controller
                present(activityViewController, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    @IBAction func onBooking(_ sender: Any) {
        SceneDelegate.shared?.loginCheckOrRestart()
    }

}
