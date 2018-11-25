//
//  BaseInfo.swift
//  Mywopin
//
//  Created by GuoXiaobin on 26/6/2018.
//  Copyright © 2018 Hydeguo. All rights reserved.
//

import Foundation
import Photos

class BaseInfo: UITableViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    @IBOutlet var nameLb:UILabel!
    @IBOutlet var icon:UIImageView!
    let imagePicker = UIImagePickerController()
    //MARK: Check if user is signed in or not
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
        
        if let myIcon = myClientVo?.icon
        {
            icon.image(fromUrl: myIcon)
        }
        nameLb.text = myClientVo?.userName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.imagePicker.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.tableFooterView=UIView(frame: CGRect.zero)
        
        let _view = UIView()
        _view.backgroundColor = .clear
        self.tableView.tableFooterView = _view
        
    }
    
    @IBAction func changePic()
    {
        
        let sheet = UIAlertController(title: nil, message: Language.getString("Select the source") , preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: Language.getString("Camera"), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openPhotoPickerWith(source: .camera)
        })
        let photoAction = UIAlertAction(title: Language.getString("Gallery"), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openPhotoPickerWith(source: .library)
        })
        let cancelAction = UIAlertAction(title: Language.getString("Cancel"), style: .cancel, handler: nil)
        sheet.addAction(cameraAction)
        sheet.addAction(photoAction)
        sheet.addAction(cancelAction)
        self.present(sheet, animated: true, completion: nil)
    }
    
    func openPhotoPickerWith(source: PhotoSource) {
        switch source {
        case .camera:
            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            if (status == .authorized || status == .notDetermined) {
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        case .library:
            let status = PHPhotoLibrary.authorizationStatus()
            if (status == .authorized || status == .notDetermined) {
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            //            self.mainImage.image = pickedImage
            if let imageData = UIImageJPEGRepresentation(pickedImage, 0.1)
            {
                icon.image = pickedImage
                uploadImage(fileName: UUID.init().uuidString+".jpg", imageData: imageData) { (url) in
                    if let _url = url
                    {
                        self.icon.image(fromUrl: _url)
                        myClientVo?.icon = _url;
                        _ = Wolf.request(type: MyAPI.changeIcon(icon: _url), completion: { (returnUser2: User?, msg, code) in
                        }, failure: nil)
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

