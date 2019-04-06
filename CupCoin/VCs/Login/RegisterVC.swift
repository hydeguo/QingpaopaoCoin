//
//  RegisterVC.swift
//  CupCoin
//
//  Created by Hydeguo on 2018/6/18.
//  Copyright © 2018 Hydeguo. All rights reserved.
//

import Foundation
import UIKit
import Moya
import RxSwift

class RegisterVC: UIViewController  , UITextFieldDelegate{
    
    
    @IBOutlet var userIDTF:UITextField!
    @IBOutlet var passwordTF:UITextField!
    @IBOutlet var password2TF:UITextField!
    @IBOutlet var submitBtn:UIButton!
//    @IBOutlet var verifyBtn:UIButton?
//    @IBOutlet var verifyBtnLabel:UILabel?
    
    var 👜 = DisposeBag()
    var verifyBtnFlag = Variable(true)
    var timerCount =  Variable(0)
    

    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: Check if user is signed in or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(gotoMainScene), name: NSNotification.Name(rawValue: "ThridPartLoginDone"), object: nil)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDTF.delegate = self
        password2TF.delegate = self
        passwordTF.delegate = self
        
        
        //        submitBtn.layer.cornerRadius = 5
//        submitBtn.layer.borderWidth = 1
//        submitBtn.layer.borderColor = UIColor.lightGray.cgColor
        
    
//        verifyBtnFlag.asObservable().bind(to: self.verifyBtn.rx_visible ).disposed(by: 👜)
//        verifyBtnFlag.asObservable().bind(to: self.verifyBtnLabel.rx.isHidden ).disposed(by: 👜)
//
//        Observable<Int>.interval(1, scheduler: SerialDispatchQueueScheduler(qos: .default))
//            .subscribe { [unowned self] event in
//                self.timerCount.value -= 1
//                if(self.timerCount.value <= 0){
//                    self.verifyBtnFlag.value = true
//                }else{
//                    self.verifyBtnFlag.value = false
//                    DispatchQueue.main.async {
//                        self.verifyBtnLabel.text = "\(self.timerCount.value)\(Language.getString("秒后重发"))"
//                    }
//                }
//            }.disposed(by: 👜)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func onConmit()
    {
        if let emailText = userIDTF.text,let psw = passwordTF.text,let psw2 = password2TF.text
        {
            guard (isValidEmail(email2Test: emailText))else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("请输入正确E-mail!"), style: AlertStyle.error)
                return
            }
            guard psw.count>0 else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("请输入密码!"), style: AlertStyle.error)
                return
            }
            guard (psw == psw2)else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("输入密码不一致"), style: AlertStyle.error)
                return
            }
            
            self.view.makeToastActivity(.center)
            emailRegisterUser(email: emailText, userName: emailText, password: psw) { (userData) in
                self.view.hideToastActivity()
                if userData != nil
                {
                    self.view.makeToastActivity(.center)
                    emailLogin(email: emailText, psw: psw, platform: 0) { (user) in
                        if user != nil
                        {
                            self.view.hideToastActivity()
                            self.gotoMainScene()
                        }
                    }
                }
            }
            
        }
    }
    
 

    @objc func gotoMainScene()
    {
        if let lang =  Language.currentAppleLanguage(), lang.contains("zh-Hans")  {
            
            main_storyboard_name = "Main_cn"
        } else {
            
            main_storyboard_name = "Main_en"
        }
        let vc = UIStoryboard(name: main_storyboard_name, bundle: nil).instantiateViewController(withIdentifier: "MainPage") as! UINavigationController
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func sendVerify()
    {
        if let phoneNum = userIDTF.text
        {
            guard (isPhoneNumber(phoneNumber: phoneNum))else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("请输入正确手机号码!"), style: AlertStyle.error)
                return
            }
            getCode(phone: phoneNum) { (flag) in
                if(flag){
                    self.timerCount.value = 60
                }
            }
            
        }
    }
}


