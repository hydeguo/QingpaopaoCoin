//
//  SignUpCup.swift
//  CupCoin
//
//  Created by Hydeguo on 2018/11/21.
//  Copyright © 2018 Wopin. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

class SignUpCup :UIViewController,UITextFieldDelegate
{
    
    @IBOutlet var textfield:UITextField?
    
    var myCupId:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield?.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func onSubmit(){
        
        if textfield?.text?.count == 0{
            _ = SweetAlert().showAlert(Language.getString("提示"), subTitle: Language.getString("请输入激活码"), style: AlertStyle.warning)
            return
        }
        
        if let cupId = myCupId , let uuid = textfield?.text
        {
            HUD.show(.progress)
            _ = Wolf.request(type: MyAPI.signinCup(cupId: cupId, uuid: uuid), completion: { (user: BaseReponse?, msg, code) in
                
                if(code == "0")
                {
                    _ = SweetAlert().showAlert(Language.getString("激活成功"), subTitle: "", style: AlertStyle.success,buttonTitle: Language.getString("确定"), action: { _ in
                        self.navigationController?.popViewController(animated: true);
                    })
                    HUD.hide()
                    return
                }
                else
                {
                    _ = SweetAlert().showAlert("Sorry", subTitle: Language.getString("激活码错误"), style: AlertStyle.warning)
                    HUD.hide()
                }
            }) { (error) in
                _ = SweetAlert().showAlert("Sorry", subTitle: error?.errorDescription, style: AlertStyle.warning)
                HUD.hide()
            }
        }
    }
    
}
