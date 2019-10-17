//
//  AttachmentHelper.swift
//  TririgaM
//
//  Created by Sharvari H V on 10/16/19.
//  Copyright © 2019 Quest. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Photos


protocol AttachmentDelegate {
    func updateAttachment(attachment : AttachmentModel)
}

class AttachmentHelper : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var attachmentModel = AttachmentModel()
    var filename : String?
    var delegate : AttachmentDelegate?
    
    weak var buttonToPresentPopoverForiPad: UIButton?
    weak var viewController: UIViewController?
    lazy var pickerController = UIImagePickerController()
    
    func selectAttachmentTapped( viewController : UIViewController) {
        
        self.viewController = viewController
        pickerController.delegate = self
        
        let actionsheet = UIAlertController(title: "Add Attachment", message:  permissionMessage, preferredStyle: .alert)
        
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
            self.checkForCameraPermission()
            
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action : UIAlertAction) in
            self.checkForPhotoLibraryPermission()
            
        }))
        
        self.viewController?.present(actionsheet,animated: true,completion: nil)
        
    }
    
    //Mark: Photo Library Permission
    func checkForPhotoLibraryPermission() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .authorized : DispatchQueue.main.async{
            self.photoLibrary(self.pickerController)
            }
            
        case .notDetermined, .denied : PHPhotoLibrary.requestAuthorization { (status) in
            guard status == .authorized else {return }
            DispatchQueue.main.async{
                self.photoLibrary(self.pickerController)
            }
            
            }
        case .restricted :
            showAlert()
            
        @unknown default:
            break
        }
    }
    
    
    //Mark: Camera Permission
    func checkForCameraPermission() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authorizationStatus {
        case .authorized : DispatchQueue.main.async{
            self.openCamera(self.pickerController)
            }
        case .notDetermined, .denied : AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
            if granted {
                DispatchQueue.main.async{
                    self.openCamera(self.pickerController)
                }
            }})
        case .restricted :
            showAlert()
            
            
        @unknown default:
            break
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Acccess restricted", message:  accessRestrictedMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.viewController?.present(alert, animated: true, completion : nil)
    }
    
    //Mark: Attachment using Camera
    func openCamera(_ imagePickerController : UIImagePickerController) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String, kUTTypeImage as String]
            self.viewController?.present(imagePickerController, animated: true, completion: nil)
        }else {
            let actionsheet = UIAlertController(title: sourceUnavailableTitle, message: sourceUnavailableMessage, preferredStyle: .alert)
            actionsheet.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.viewController?.present(actionsheet,animated: true,completion: nil)
        }
        
    }
    
    //Attachment using Photo Library
    func photoLibrary(_ imagePickerController : UIImagePickerController) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String, kUTTypeImage as String]
            self.viewController?.present(imagePickerController, animated: true, completion: nil)
        }else {
            let actionsheet = UIAlertController(title: sourceUnavailableTitle, message: sourceUnavailableMessage, preferredStyle: .alert)
            actionsheet.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.viewController?.present(actionsheet,animated: true,completion: nil)
        }
        
    }
    
    func showRenameAlert(_ model : AttachmentModel) {
        
        var model = model
        
        let alertController = UIAlertController(title: "Attachment", message: fileRenameMessage, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            if let name = textField.text, !name.isEmpty{
                
                model.name = name + HelperClass.getDateTime() + "." + ( model.fileExtension ?? "" )
                
            }
            self.saveAttachment(model : model)
            self.delegate?.updateAttachment(attachment: self.attachmentModel)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert) in
            self.saveAttachment(model: model)
            self.delegate?.updateAttachment(attachment: self.attachmentModel)
            
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.viewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    func presentAttachment(_ model : AttachmentModel) {
        guard let localFileName = model.fileName, let url = model.url else {return}
        
        let dirURL = localDirectory(lastComponent: localFileName)
        
        if FileManager.default.fileExists(atPath: dirURL.path) {
            self.loadDataInView(filePath: dirURL)
        }
            
        else {
            
            let request2 = ServiceClass.init(url: url, httpMethod: .get)
            request2.prepareHTTPRequest(data: nil)
            request2.downloadContent { result in
                switch result{
                case .success(let localURL): guard  let url = localURL else{ print("Corrupted")
                    return }
                do {
                    let dirFileName = self.localDirectory(lastComponent: localFileName)
                    try FileManager.default.copyItem(at: url, to: dirFileName)
                    DispatchQueue.main.async {
                        self.loadDataInView(filePath: dirFileName)
                    }
                }
                catch{
                    print("Error writing to file")
                    }
                case .failure(let error): print(error)
                }
            }
            
        }
    }
    
    func localDirectory( lastComponent : String) -> URL {
        let documentURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileURL = documentURL.appendingPathComponent(lastComponent)
        
        return destinationFileURL
    }
    
    func loadDataInView(filePath : URL) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TMDetailViewController") as? TMDetailViewController{
            vc.filePath = filePath
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func saveAttachment(model : AttachmentModel){
        do {
            guard let attachmentName = model.name, let attachmentURL = model.url else {
                return
            }
            let dirFileName = self.localDirectory(lastComponent: attachmentName)
            try FileManager.default.copyItem(at: attachmentURL, to: dirFileName)
            self.attachmentModel = model
            self.attachmentModel.url = dirFileName
        }
        catch{
            print("Error writing to file")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageURL = info[.imageURL] as? URL {
            createAttachmentModel(imageURL)
            
        }
        
        if let videoURL = info[.mediaURL] as? URL {
            createAttachmentModel(videoURL)
        }
        
        picker.dismiss(animated: true) {
            self.showRenameAlert(self.attachmentModel)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func createAttachmentModel(_ url : URL){
        let fileExtension = url.pathExtension
        let fileName = url.deletingPathExtension().lastPathComponent + HelperClass.getDateTime() + "." + fileExtension
        attachmentModel.name = fileName
        attachmentModel.url = url
        attachmentModel.fileExtension = fileExtension
        attachmentModel.content = NSData(contentsOf: url) as Data?
    }
    
}
