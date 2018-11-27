//
//  AddWifiControllPage.swift
//  CupCoin
//
//  Created by Hydeguo on 2018/11/26.
//  Copyright © 2018 Wopin. All rights reserved.
//

import Foundation



class AddWifiControllPage: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.backBarButtonItem?.title = ""
        //        self.navigationItem.title = Language.getString("灯光设置")
        
        self.tabBarController?.tabBar.isHidden = true
    }

    
}

