//
//  ChangeEmailPassword.swift
//  CupCoin
//
//  Created by Hydeguo on 2018/11/20.
//  Copyright © 2018 Wopin. All rights reserved.
//


import Foundation
import UIKit
import Moya
import RxSwift

class ChangeEmailPassword: UIViewController  , UITextFieldDelegate{
    
    
    @IBOutlet var passwordTF:UITextField!
    @IBOutlet var passwordTF2:UITextField!
    @IBOutlet var submitBtn:UIButton!
    
    var 👜 = DisposeBag()
    var verifyBtnFlag = Variable(true)
    var timerCount =  Variable(0)
    
    
    
    //MARK: Check if user is signed in or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.delegate = self
        passwordTF2.delegate = self
        //        submitBtn.layer.cornerRadius = 5
        //        submitBtn.layer.borderWidth = 1
        //        submitBtn.layer.borderColor = UIColor.lightGray.cgColor
  
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func onConmit()
    {
        if let psw = passwordTF.text,let psw2 = passwordTF2.text
        {
            UIApplication.shared.keyWindow?.endEditing(true)
            guard psw.count>0 else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("请输入密码!"), style: AlertStyle.error)
                return
            }
            guard psw == psw2 else {
                _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("输入密码不一致!"), style: AlertStyle.error)
                return
            }
            
            _ = Wolf.request(type: MyAPI.changePasswordByEmail(  password: psw), completion: { (info: BaseReponse?, msg, code) in
                
                if(code == "0")
                {
//                    let userInfo = ["userId" : phoneNum, "password" : psw,"platform":"0"]
//                    UserDefaults.standard.set(userInfo, forKey: "userInformation")
                    _ = SweetAlert().showAlert("修改成功", subTitle: "", style: AlertStyle.success)
                    return
                }
                else
                {
                    _ = SweetAlert().showAlert("Sorry", subTitle: msg, style: AlertStyle.warning)
                }
            }) { (error) in
                _ = SweetAlert().showAlert("Sorry", subTitle: error?.errorDescription, style: AlertStyle.warning)
            }
        }
    }
    
}


