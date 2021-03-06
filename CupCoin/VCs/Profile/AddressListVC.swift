//
//  AddressListVC.swift
//  CupCoin
//
//  Created by Hydeguo on 2018/7/8.
//  Copyright © 2018 Hydeguo. All rights reserved.
//

import Foundation



class AddressListVC: UITableViewController {
    
    var cellHeight:CGFloat = 140
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        if myClientVo?.addressList == nil
        {
            myClientVo?.addressList = []
        }
        let returnButton = UIBarButtonItem(image: R.image.back(), style: .plain, target: self, action: #selector(onReturn))
        self.navigationController!.topViewController!.navigationItem.leftBarButtonItem =  returnButton
        
        let addButton =  UIBarButtonItem(title: Language.getString("新增") , style: .plain, target: self, action:  #selector(onAddNew))
       
        self.navigationController!.topViewController!.navigationItem.rightBarButtonItem =  addButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.tableView.reloadData()
        
    }
    @objc func onReturn()
    {
                self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
    }
    @objc func onAddNew()
    {
        let storyboard = UIStoryboard(name: main_storyboard_name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddressInfoVC") as! UITableViewController
//        let vc = R.storyboard.main.addressInfoVC()
        self.show(vc, sender: nil)
    }
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAddress" {
            if let btn = sender  {
                let indexPath = (btn as! UIButton) .tag
                let controller = segue.destination as! AddressInfoVC
                controller.onSetData (data: (myClientVo?.addressList![indexPath])!)
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "selectAddress" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let post = posts[indexPath.row]
//                let controller = (segue.destination as! UINavigationController).topViewController as! AddressInfoVC
//                controller.detailItem = post
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @IBAction func onSetDefault(_ btn:UIButton)
    {
        
        if let address = myClientVo?.addressList![btn.tag]
        {
            _ = Wolf.request(type: MyAPI.setDefaultAddress(addressId: address.addressId), completion: { (user: User?, msg, code) in
                if(code == "0")
                {
                    myClientVo = user
                    self.tableView.reloadData()
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
    
    @IBAction func onDelAddress(_ btn:UIButton)
    {
        
        if let address = myClientVo?.addressList![btn.tag]
        {
            _ = SweetAlert().showAlert("提示", subTitle: "确定删除该地址？" , style: AlertStyle.none, buttonTitle:"确定", buttonColor: main_color, otherButtonTitle:  "取消", otherButtonColor: main_color) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    _ = Wolf.request(type: MyAPI.delAddress(addressId: address.addressId), completion: { (res: BaseReponse?, msg, code) in
                        if(code == "0")
                        {
                            myClientVo?.addressList?.remove(at: btn.tag)
                            self.tableView.reloadData()
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
        
    }
    
    // MARK: - Table View
    //    override func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 130
    //    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myClientVo!.addressList!.count
    }
    
    override func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        if let address = myClientVo?.addressList![indexPath.row]
        {
            cell.line1.text = "\(address.userName ) \(String(Int(address.tel!)))"
            cell.line2.text = "\(address.address1 ?? "" ) \(String(address.address2 ?? ""))"
            cell.defaultBtn.isSelected = address.isDefault == true
        }
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.defaultBtn.tag = indexPath.row
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NSLog("You selected cell number: \(indexPath.row)!")
//        self.performSegue(withIdentifier: "yourIdentifier", sender: self)
        selectedAddress = myClientVo?.addressList![indexPath.row]
        onReturn()
    }
    
}
