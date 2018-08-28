//
//  ViewController.swift
//  AFNetWorkingDemo
//
//  Created by maconelsun(孙炜) on 2018/8/15.
//  Copyright © 2018年 maconelsun(孙炜). All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    static let afManager = AFHTTPSessionManager()
    let urlTextField = UITextField()
    let respTextView = UITextView()
    let doButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        doInitSubview()
        doLayoutSubview()
    }
    
    func doInitSubview() {
        urlTextField.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
        urlTextField.layer.borderWidth = 1
        urlTextField.text = "http://127.0.0.1:8000"
        self.view.addSubview(urlTextField)
        
        respTextView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
        respTextView.layer.borderWidth = 1
        self.view.addSubview(respTextView)
        
        doButton.setTitle("do", for: .normal)
        doButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        doButton.addTarget(self, action: #selector(onDoButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.view.addSubview(doButton)
    }
    
    func doLayoutSubview() {
        urlTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(40)
            make.left.equalTo(self.view).offset(20)
            make.height.equalTo(36)
        }
        
        respTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(urlTextField.snp.bottom).offset(20)
            make.bottom.equalTo(doButton.snp.top).offset(-20)
            make.left.equalTo(self.view).offset(20)
        }
        
        doButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-20)
            make.size.equalTo(CGSize(width: 120, height: 36))
        }
    }
    
    func request(url: String) {
        ViewController.afManager.requestSerializer = AFHTTPRequestSerializer()
        ViewController.afManager.responseSerializer = AFHTTPResponseSerializer()
        ViewController.afManager.responseSerializer.acceptableContentTypes = ["text/html"]
        ViewController.afManager.get(url, parameters: nil, progress: { (progress) in
            NSLog("request, progress, progress=%@", progress)
        }, success: { (task, resp) in
            guard let data = resp as? Data else {
                NSLog("request, success, data=nil)")
                return
            }
            guard let html = String(data: data, encoding: String.Encoding.utf8) else {
                NSLog("request, success, html=nil)")
                return
            }
            NSLog("request, success, html.len=%d)", html.lengthOfBytes(using: .utf8))
            self.respTextView.text = html
        }) { (task, error) in
            NSLog("request, fail, error=%@", error.localizedDescription)
        }
    }
    
    func request2() {
        let config = URLSessionConfiguration.default
        let manager = AFURLSessionManager(sessionConfiguration: config)
        guard let url = URL(string: "http://127.0.0.1:8000") else {
            return
        }
        let request = URLRequest(url: url)
        let dataTask = manager.dataTask(with: request, uploadProgress: { (progress) in
            NSLog("request2: upload progress=%@", progress)
        }, downloadProgress: { (progress) in
            NSLog("request2: download progress=%@", progress)
        }) { (resp, respObj, error) in
            NSLog("request2: complete, resp=%@, respObj=%@, error=%@", resp, String(describing: respObj), String(describing: error))
        }
        dataTask.resume()
    }
    
    @objc func onDoButtonTouchUpInside(sender: UIButton) {
        request(url: urlTextField.text ?? "http://127.0.0.1:8000")
    }
}
