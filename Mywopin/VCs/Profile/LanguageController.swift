//
//  LanguageController.swift
//  CupCoin
//
//  Created by Hydeguo on 2018/12/12.
//  Copyright © 2018 Wopin. All rights reserved.
//

import Foundation
import UserNotifications


class LanguageController: UITableViewController {
    
    @IBOutlet var selectBox0:UIButton?
    
    @IBOutlet var selectBox1:UIButton?
    
    var curLang :String? = "en"
    //MARK: Check if user is signed in or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.tableView.separatorInset = .zero;
        
        self.tableView.tableFooterView=UIView(frame: CGRect.zero)
        
//        print(Language.currentAppleLanguage())
        if Language.currentAppleLanguage() == "zh-Hans"{
            curLang = "zh-Hans"
        }else{
            curLang =  "en"
        }
        
        selectLang()
        
        let rightBtn = UIBarButtonItem(title: Language.getString("保存"), style: .plain, target: self, action: #selector(save(_:)))
        
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    func selectLang(){
        
        if curLang == "zh-Hans"{
            selectBox0?.isSelected = true
            selectBox1?.isSelected = false
        }else{
            
            selectBox0?.isSelected = false
            selectBox1?.isSelected = true
        }
    }
    
    
    @objc func save(_ sender: Any) {

        
        var lang = "en"
        if selectBox0?.isSelected == true{
            lang = "zh-Hans"
        }
        
        if Language.currentAppleLanguage() != lang { //"zh-Hans"
            Language.setAppleLAnguageTo(lang: lang)
            
            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            if lang == "en" {
                rootviewcontroller.rootViewController = UIStoryboard(name: "Main_en", bundle: nil).instantiateViewController(withIdentifier: "LandingPage")
            } else {
                rootviewcontroller.rootViewController = UIStoryboard(name: "Main_cn", bundle: nil).instantiateViewController(withIdentifier: "LandingPage")
            }
            
            if switchNotice
            {
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                NoticeController().createLocalNotice()

            }
            
            
            let mainwindow = (UIApplication.shared.delegate?.window!)!
            mainwindow.backgroundColor = UIColor.white
            UIView.transition(with: mainwindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
            }) { (finished) -> Void in
            }
        }
        else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        curLang = "en"
        if indexPath.row == 0{
            curLang = "zh-Hans"
        }
        
        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: false)
            selectLang()
        }
        
    }
    
    
}
