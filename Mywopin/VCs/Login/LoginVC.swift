//
//  LoginVC.swift
//  Mywopin
//
//  Created by Hydeguo on 2018/6/17.
//  Copyright © 2018 Hydeguo. All rights reserved.
//

import Foundation


import UIKit
import Moya
import Toast_Swift

class LoginVC: UIViewController , UITextFieldDelegate{
    
    
    @IBOutlet var userIDTF:UITextField!
    @IBOutlet var passwordTF:UITextField!
    @IBOutlet var submitBtn:UIButton!
    
    //MARK: Push to relevant ViewController
    func pushTo(viewController: ViewControllerType)  {
        switch viewController {
        case .conversations:
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Navigation") as! NavVC
            //            self.present(vc, animated: false, completion: nil)
            break
        case .welcome:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Welcome") as! WelcomeVC
//            self.present(vc, animated: false, completion: nil)
            break
        }
    }
    
    //MARK: Check if user is signed in or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(gotoMainScene), name: NSNotification.Name(rawValue: "ThridPartLoginDone"), object: nil)
        
        if let phone = myClientVo?.phone
        {
            userIDTF.text = String(Int(phone))
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIDTF.delegate = self
        passwordTF.delegate = self
//        submitBtn.layer.cornerRadius = 5
//        submitBtn.layer.borderWidth = 1
//        submitBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//
//    }
    @IBAction func onReturn()
    {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func gotoMainScene()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainPage") as! UINavigationController
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func onConmit()
    {
        if let emailText = userIDTF.text,let psw = passwordTF.text
        {
            guard (isValidEmail( email2Test: emailText))else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("请输入正确E-mail!"), style: AlertStyle.error)
                return
            }
            guard psw.count>0 else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("请输入密码!"), style: AlertStyle.error)
                return
            }
            self.view.makeToastActivity(.center)
            emailLogin(email: emailText, psw: psw, platform: 0) { (user) in
                self.view.hideToastActivity()
                if user != nil
                {
                    self.gotoMainScene()
                }
            }
        }
    }
    
    @IBAction func onForget()
    {
        if let emailText = userIDTF.text
        {
            guard (isValidEmail( email2Test: emailText))else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("请输入正确E-mail"), style: AlertStyle.error)
                return
            }
            
            _ = Wolf.request(type: MyAPI.resetEmailPassword(email: emailText), completion: { (user: BaseReponse?, msg, code) in
                if(code == "0"){
                    _ = SweetAlert().showAlert(Language.getString("提示"), subTitle: Language.getString("已经发送重置密码的链接到您的E-mail"), style: AlertStyle.success)
                }else{
                    
                    _ = SweetAlert().showAlert(Language.getString("提示"), subTitle: Language.getString("您的E-mail未注册"), style: AlertStyle.warning)
                }
            }, failure: nil)
        }
    }
}


