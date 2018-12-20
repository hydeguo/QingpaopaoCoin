//
//  CoinLinkViewController.swift
//  CupCoin
//
//  Created by Hydeguo on 2018/12/20.
//  Copyright © 2018 Wopin. All rights reserved.
//

import Foundation


class CoinLinkViewController: UIViewController {
    
    
    @IBOutlet var web:UIWebView?
    
    
    override func viewDidLoad() {
        
        
        web?.loadRequest(URLRequest(url: URL(string: "http://www.h-popo.com")!))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
