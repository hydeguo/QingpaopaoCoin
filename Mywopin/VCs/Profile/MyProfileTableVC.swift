//
//  MyProfileTableVC.swift
//  Mywopin
//
//  Created by Hydeguo on 2018/6/3.
//  Copyright © 2018 Hydeguo. All rights reserved.
//

import UIKit




class MyProfileTableVC: UITableViewController{
    
    

    @IBOutlet var drinkCupLabel:UILabel!
    @IBOutlet var drinkCupTotalLabeL:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        navigationItem.leftBarButtonItem = editButtonItem
        
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //        navigationItem.rightBarButtonItem = addButton
        

        
        
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        navigationItem.titleView?.tintColor = UIColor.colorFromRGB(0x7b43d1)
        
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
        updateDrinkText()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDrinkText()
    {
        if let _todayDrinks = todayDrinks
        {
            if _todayDrinks.drinks!.count > 1{
                self.drinkCupLabel.text = String(_todayDrinks.drinks!.count)//"\(String(_todayDrinks.drinks!.count)) \(Language.getString("杯"))"
            }else{
                self.drinkCupLabel.text = String(_todayDrinks.drinks!.count)//"\(String(_todayDrinks.drinks!.count)) \(Language.getString("杯1"))"
            }
            
        }
        if Int(myClientVo?.drinks ?? 0) > 1{
            self.drinkCupTotalLabeL.text = String(Int(myClientVo?.drinks ?? 0))//"\(String(Int(myClientVo?.drinks ?? 0))) \(Language.getString("杯"))"
        }else{
            self.drinkCupTotalLabeL.text = String(Int(myClientVo?.drinks ?? 0))//"\(String(Int(myClientVo?.drinks ?? 0))) \(Language.getString("杯1"))"
        }
        
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        print("segue.identifier..\(segue.identifier)")
//        if segue.identifier == "showDetail" {
//            // if let indexPath = //tableView.indexPathForSelectedRow {
//            let object = rArr[(sender as! UIButton).tag ]
//            let controller = segue.destination  as! DetailViewController
//
//            controller.detailItem = object
//            //                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//            //                controller.navigationItem.leftItemsSupplementBackButton = true
//
//        }
        if segue.identifier == "showFans" {
            let controller = segue.destination as! MyFansList
            controller.mode = .fans
        }
        if segue.identifier == "showMyFollows" {
            let controller = segue.destination as! MyFansList
            controller.mode = .follow
        }
        if segue.identifier == "collectionPosts" {
            let controller = segue.destination as! PostListViewController
            controller.mode = .collect
        }
        if segue.identifier == "history"{
            let controller = segue.destination as! PostListViewController
            controller.mode = .history
        }
        if segue.identifier == "collectionPosts"{
            let controller = segue.destination  as! PostListViewController
            controller.mode = .collect
        }
        if segue.identifier == "followingPosts"{
            let controller = segue.destination  as! PostListViewController
            controller.mode = .following
        }
        
    }
    
    // MARK: - Table View
  

    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    
    
    
}





