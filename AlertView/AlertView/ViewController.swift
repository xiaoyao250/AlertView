//
//  ViewController.swift
//  AlertView
//
//  Created by Sowrirajan Sugumaran on 9/13/17.
//  Copyright © 2017 Sowrirajan Sugumaran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Declare the alertview class
    var alertView = AlertVw()
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var typeSegment: UISegmentedControl!
    var direction : String?
    var titleText : String?
    var descriptionText : String?
    var imgAlert : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actAlert(_ sender: Any) {
        
        // simple way to show alert view
        alertView = AlertVw.init(title: "新建标签", alertType: .input, message: "输入标签...", btnDoneTitle: "确认")
        
        alertView.show(animated: true)
        
        
        //可以弹出内容的view
//        let view = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
//        view.backgroundColor = UIColor.red
//        alertView.dialogView.addSubview(view)
    }
    
    // to show types of alert view
    @IBAction func alertTypes(_ sender: Any) {
        
        let alertView = AlertVw(title:"放弃行程", alertType: .text, message:"真的要放弃吗？", btnDoneTitle: "放弃")
        
        alertView.show(animated: true)
    }
    
    // to set alert view direction
    @IBAction func indexChanged(_ sender: Any) {
        
       
    }
    
    func actShowAlert(title : String, description : String, imageName : UIImage, direction: String, clearBG: Bool) {
        
        
    }
    
    // to clear background color of alert view
    @IBAction func actClearBackground(_ sender: UISwitch) {
        
    }
}

