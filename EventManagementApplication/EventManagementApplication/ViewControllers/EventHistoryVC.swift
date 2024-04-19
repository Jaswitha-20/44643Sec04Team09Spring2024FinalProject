//
//  EventHistoryVC.swift
//  EventManagementApplication
//
//  Created by Divya Sarvepalli on 3/21/24.
//

import UIKit
import AnimatedGradientView

class EventHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noData: UILabel!

    var eventRecord: [EventDetailData] = []

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
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventHistroyRecord()
    }
    
    
    func eventHistroyRecord(){
        FireStoreManager.shared.getEventHistory { event in
            self.eventRecord = event
            self.tableView.isHidden = true

            self.tableView.isHidden = self.eventRecord.count != 0 ? false : true
            self.noData.isHidden = self.eventRecord.count != 0 ? true : false

            print(self.eventRecord)
            
            self.tableView.reloadData()

        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return eventRecord.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let eventRecord = eventRecord[indexPath.row]

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            
            cell.setData(title: eventRecord.event_title ?? "", location: eventRecord.location ?? "", description: "", date: eventRecord.date ?? "")
            
            return cell
        }

        // MARK: - UITableViewDelegate

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let eventRecord = eventRecord[indexPath.row]

            let vc = storyboard?.instantiateViewController(withIdentifier: "EventBookingVC") as! EventBookingVC
            vc.eventData = eventRecord
            vc.organiserDetail = eventRecord.organizer
            vc.isHistory = true
            navigationController?.pushViewController(vc, animated: true)
        }
}