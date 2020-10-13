//
//  ViewController.swift
//  TestSMS
//
//  Created by 胡冬冬 on 2020/8/8.
//  Copyright © 2020 胡冬冬. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController ,MFMessageComposeViewControllerDelegate ,UITextFieldDelegate{

    @IBOutlet weak var phoneNumberInput: UITextField!
    
    @IBOutlet weak var bedNoInput: UITextField!
    
    @IBOutlet weak var nameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberInput.becomeFirstResponder()
        phoneNumberInput.delegate = self
        bedNoInput.delegate = self
        nameInput.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func phoneNumberInput(_ sender: Any){
        phoneNumberInput.layer.borderColor = UIColor.red.cgColor
        phoneNumberInput.layer.borderWidth = 0
        return;
    }
    
    @IBAction func bedNoInput(_ sender : Any) {
        bedNoInput.layer.borderColor = UIColor.red.cgColor
        bedNoInput.layer.borderWidth = 0
        return;
    }
    
    @IBAction func nameInput(_ sender : Any) {
        nameInput.layer.borderColor = UIColor.red.cgColor
        nameInput.layer.borderWidth = 0
        return;
    }
    
    
    @IBAction func sendSMS(_ sender: Any) {
        checkInfo()
    }
    func checkInfo(){
        let name = nameInput.text
        let phone = phoneNumberInput.text
        let bedno = bedNoInput.text
        if phone == "" {
            phoneNumberInput.layer.borderColor = UIColor.red.cgColor
            phoneNumberInput.layer.borderWidth = 1
            phoneNumberInput.layer.cornerRadius = 6
            phoneNumberInput.becomeFirstResponder()
            return;
        }else{
            phoneNumberInput.layer.borderWidth = 0
        }
        if bedno == "" {
            bedNoInput.layer.borderColor = UIColor.red.cgColor
            bedNoInput.layer.borderWidth = 1
            bedNoInput.layer.cornerRadius = 6
            bedNoInput.becomeFirstResponder()
            return;
        }else{
            bedNoInput.layer.borderWidth = 0
        }
        if name == "" {
            nameInput.layer.borderColor = UIColor.red.cgColor
            nameInput.layer.borderWidth = 1
            nameInput.layer.cornerRadius = 6
            nameInput.becomeFirstResponder()
            return;
        } else {
            nameInput.layer.borderWidth = 0
        }
        sendSMS(phone: phone ?? "" , bedNo: bedno ?? "" , name: name ?? "");
    }
    
    func sendSMS( phone : String,bedNo : String, name : String ) {
                   //判断设备是否能发短信(真机还是模拟器)
           if MFMessageComposeViewController.canSendText() {
           let controller = MFMessageComposeViewController()
           //短信的内容,可以不设置
            controller.body = "\(bedNo)床\(name)：您好，刚才查房时发现您未在病房内，请您接到本信息后迅速赶回本病区，否则由此引发的法律风险及后果由您自行承担。徐州矿务总医院消化科";
           //联系人列表
           controller.recipients = [phone]
           //设置代理
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
           } else {
               showInfo("设备不支持")
           }
    }
    
    //MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        //判断短信的状态
        switch result{
        case .sent:
//            showInfo("短信已发送")
            break;
        case .cancelled:
//            showInfo("短信取消发送")
            break
        case .failed:
//            showInfo("短信发送失败")
            break;
        default:
//            showInfo("短信已发送")
            break
        }
        nameInput.text = ""
        phoneNumberInput.text = ""
        bedNoInput.text = ""
        phoneNumberInput.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case phoneNumberInput:
            bedNoInput.becomeFirstResponder()
        case bedNoInput:
            nameInput.becomeFirstResponder()
        case nameInput:
            checkInfo()
        default:
            break
        }
        return true;
    }
    
    func showInfo(_ info : String ){
        let alertController = UIAlertController(title: "系统提示",
                        message: info, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            
        })
//        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

