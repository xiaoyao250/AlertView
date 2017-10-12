//
//  AlertVw.swift
//  AlertView
//
//  Created by Sowrirajan Sugumaran on 9/13/17.
//  Copyright © 2017 Sowrirajan Sugumaran. All rights reserved.
//

import UIKit

enum AlertType {
    case text
    case input
}

class AlertVw: UIView, AlertProtocol {
    
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
        dialogView.layer.cornerRadius = 5
        dialogView.clipsToBounds = true
        return dialogView
    }()
    var appearFrom = String()
    var clearBackground = Bool()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        return titleLabel
    }()
    fileprivate lazy var lblMessage: UILabel = {
        let lblMessage = UILabel()
        lblMessage.numberOfLines = 0
        lblMessage.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblMessage.font = UIFont.systemFont(ofSize: 15)
        lblMessage.textAlignment = .center
        lblMessage.textColor = UIColor.darkGray
        lblMessage.sizeToFit()
        return lblMessage
    }()
    fileprivate lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.placeholder = "请输入标签..."
        textField.textColor = UIColor.gray
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 0))
        //设置显示模式为永远显示(默认不显示)
        textField.leftViewMode = .always;
        return textField
    }()
    
    fileprivate lazy var btnCancel: UIButton = {
        let btnCancel = UIButton()
        btnCancel.backgroundColor =  UIColor.darkText
        btnCancel.setTitleColor(UIColor.groupTableViewBackground, for: UIControlState.normal)
        btnCancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return btnCancel
    }()
    
    fileprivate lazy var btnDone: UIButton = {
        let btnDone = UIButton()
        btnDone.backgroundColor =  UIColor.darkText
        btnDone.setTitleColor(UIColor.groupTableViewBackground, for: UIControlState.normal)
        btnDone.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return btnDone
    }()
    
    convenience init(title: String, alertType: AlertType, message: String, btnDoneTitle: String) {
        self.init(frame:UIScreen.main.bounds)
        self.initialise(title: title, alertType: alertType, message: message, btnDoneTitle: btnDoneTitle)
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
    
    public func getBtnDone() -> UIButton {
        return btnDone
    }
    
    public func getTextField() -> UITextField {
        return textField
    }
    
    func initialise(title: String, alertType: AlertType, message: String, btnDoneTitle: String) {
        // get dynamic width for alertView and all controlls
        
        let dialogViewWidth: CGFloat = 270
        backgroundView.frame = self.frame
        addSubview(backgroundView)
        
        titleLabel.text = title
        titleLabel.frame.origin.y = 35
        titleLabel.center.x = 15
        titleLabel.frame.size = CGSize.init(width: dialogViewWidth - 30, height: 36)
        dialogView.addSubview(titleLabel)
        
        let contentVY: CGFloat = (titleLabel.frame.origin.y + titleLabel.frame.size.height + 15)
        var contentVW: CGFloat = 0
        var contentVH: CGFloat = 0
        if alertType == .text {
            lblMessage.text = message
            contentVW = dialogViewWidth - 30
            contentVH = lblMessage.text!.height(with: contentVW, font: lblMessage.font)
            lblMessage.frame = CGRect(x: 15, y: contentVY, width: contentVW, height: contentVH)
            dialogView.addSubview(lblMessage)
        }else {
            textField.placeholder = message
            contentVW = dialogViewWidth - 30
            contentVH = 45
            textField.frame = CGRect(x: 15, y: contentVY, width: contentVW, height: contentVH)
            dialogView.addSubview(textField)
        }
        
        let btnCancelW = (dialogViewWidth - 45) / 2
        btnCancel.addTarget(self, action: #selector(didButtonTapped), for: UIControlEvents.touchUpInside)
        btnCancel.frame = CGRect(x: 15, y: contentVY + contentVH + 20, width: btnCancelW, height:40)
        btnCancel.setTitle("取消", for: UIControlState.normal)
        dialogView.addSubview(btnCancel)
        btnDone.setTitle(btnDoneTitle, for: UIControlState.normal)
        btnDone.addTarget(self, action: #selector(didButtonTapped), for: UIControlEvents.touchUpInside)
        btnDone.frame = btnCancel.frame
        btnDone.frame.origin.x = 15 + btnCancelW + 15
        dialogView.addSubview(btnDone)
        
        // set dynamic height for alert view and their controls
        let dialogViewHeight = btnDone.frame.maxY + 20
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: dialogViewWidth, height: dialogViewHeight)
        
        if alertType == .text  {
            lblMessage.center = CGPoint(x: dialogView.frame.size.width / 2, y: dialogView.frame.size.height/2)
        }else {
            textField.center = CGPoint(x: dialogView.frame.size.width / 2, y: dialogView.frame.size.height/2)
        }
        
        self.createGradientLayer(view: dialogView, colorOne: UIColor.white, colorTwo: UIColor.white)
        addSubview(dialogView)
        
    }
    
    func didBtnDoneTappad() {
        print("btnDone isTappad,get btn use getBtnDone()")
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

extension String {
    /// 返回文本高度
    ///
    /// - Parameters:
    ///   - width: 文本宽度
    ///   - font: 文本字体
    /// - Returns: 文本占高度
    public func height(with width: CGFloat ,font:UIFont) -> CGFloat {
        let calString = self as NSString
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let boundingBox = calString.boundingRect(with: constraintRect, options: option, attributes: attributes, context: nil)
        return boundingBox.height
    }
}
