//
//  AlertVw.swift
//  AlertView
//
//  Created by Sowrirajan Sugumaran on 9/13/17.
//  Copyright © 2017 Sowrirajan Sugumaran. All rights reserved.
//

import UIKit

class AlertVw: UIView, alertProtocol {
    
    // Declare the protocol controls
    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        return backgroundView
    }()
    lazy var dialogView: UIView = {
        let dialogView = UIView()
        dialogView.backgroundColor = UIColor.clear
        dialogView.layer.cornerRadius = 10
        dialogView.clipsToBounds = true
        return dialogView
    }()
    var appearFrom = String()
    var clearBackground = Bool()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        imageView.alpha = 0.9
        imageView.contentMode = .scaleAspectFit
        

        return imageView
    }()
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Futura", size: 22)
        titleLabel.textAlignment = .left
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        return titleLabel
    }()
    fileprivate lazy var lblMessage: UILabel = {
        let lblMessage = UILabel()
        lblMessage.numberOfLines = 0
        lblMessage.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblMessage.font = UIFont(name: "Futura", size: 17)
        lblMessage.textAlignment = NSTextAlignment.center
        lblMessage.textColor = UIColor.darkGray
        lblMessage.sizeToFit()
        return lblMessage
    }()
    fileprivate lazy var btnDone: UIButton = {
        let btnDone = UIButton()
        btnDone.addTarget(self, action: #selector(didButtonTapped), for: UIControlEvents.touchUpInside)
        btnDone.backgroundColor =  UIColor.darkText
        btnDone.setTitleColor(UIColor.groupTableViewBackground, for: UIControlState.normal)
        btnDone.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 17)
        return btnDone
    }()
    
    fileprivate var btnTxtColor : UIColor?
    fileprivate var btnBGColor = UIColor()
    fileprivate var btnFont = UIFont()
    
    fileprivate var lblTitleTxtColor = String()
    fileprivate var lblTitleTxtFont = String()
    
    fileprivate var lblDesTxtColor = String()
    fileprivate var lblDesTxtFont = String()

    
    convenience init(title:String, description:String, image:UIImage) {
        self.init(frame:UIScreen.main.bounds)
        self.initialise(title:title, description:description, image:image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // set title label font
    func setTitleFont(font:UIFont) {
        titleLabel.font = font
    }
    
    // set title label color
    func setTitleColor(color:UIColor) {
        titleLabel.textColor = color
    }
    
    // set description label font
    func setDescriptionFont(font:UIFont) {
        lblMessage.font = font
    }
    
    // set description label color
    func setDescriptionColor(color:UIColor) {
        lblMessage.textColor = color
    }
    
    // set done button title
    func setBtnTitle(name:String) {
        btnDone.setTitle(name as String?, for: UIControlState.normal)
    }
    
    // set done button background color
    public func setBtnBGColor(color:UIColor) {
        btnDone.backgroundColor = color
    }
    
    // set done button text color
    func setBtnTxtColor(color:UIColor) {
        btnDone.titleLabel?.textColor = color
    }
    
    // set done button text font
    public func setBtnFont(font:UIFont) {
        btnDone.titleLabel?.font = font
    }
    
    // set alert view background color
    public func setViewBGColor(color:UIColor) {
        backgroundView.backgroundColor = color
    }
    
    
    func initialise(title:String, description:String, image:UIImage) {
        
        // get dynamic width for alertView and all controlls
        
        imageView.image = image
        titleLabel.text = title
        lblMessage.text = description
        
        btnDone.setTitle("Okay", for: UIControlState.normal)
        
        let dialogViewWidth = 260
        
        backgroundView.frame = self.frame
        
        imageView.frame.origin = CGPoint(x: -13, y: -13)
        imageView.frame.size = CGSize(width: 70 , height: 70)
        titleLabel.frame = CGRect(x: self.imageView.frame.size.width-5, y: self.imageView.frame.size.height/2 - imageView.frame.size.height/4-5, width: CGFloat(dialogViewWidth) + 8, height: 70)
        //TODO: height = 50 ,应该为计算得到的文字高度
        lblMessage.frame = CGRect(x: 17, y: Int(titleLabel.frame.origin.y + titleLabel.frame.size.height + 8 + 10), width: dialogViewWidth - 30, height: 50)
        btnDone.frame = CGRect(x: 8, y:lblMessage.frame.origin.y + lblMessage.frame.size.height + 8, width: 100, height:40)
        
        // set dynamic height for alert view and their controls
        let dialogViewHeight = titleLabel.frame.height + 8 + lblMessage.frame.height + 8 + btnDone.frame.height + 8 + 30
        btnDone.frame.origin = CGPoint(x:CGFloat(dialogViewWidth)-105, y:dialogViewHeight-45)
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: CGFloat(dialogViewWidth), height: dialogViewHeight)
        
        lblMessage.center = CGPoint(x: dialogView.frame.size.width / 2, y: dialogView.frame.size.height/2)
        
        addSubview(backgroundView)
        dialogView.addSubview(imageView)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(lblMessage)
        dialogView.addSubview(btnDone)
        
        self.createGradientLayer(view: dialogView, colorOne: UIColor.white, colorTwo: UIColor.white)
        addSubview(dialogView)
        
    }
    
    // dismiss the alert view
    func didButtonTapped() {
        dismiss(animated: true)
    }
    
    // set gradient colors
    func createGradientLayer(view:UIView, colorOne:UIColor, colorTwo:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
