//
//  ViewController.swift
//  demoPersistence
//
//  Created by maconelsun(孙炜) on 2018/8/13.
//  Copyright © 2018年 maconelsun(孙炜). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let contentTitle = UILabel()
    let contentTextView = UITextView()
    let secureContentTitle = UILabel()
    let secureContentTextView = UITextView()
    var content: Content?
    var secureContent: SecureContent?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        doCreate()
        doLayout()
        load()
        loadSecure()
        contentTextView.text = content?.content
        secureContentTextView.text = secureContent?.content
    }
    
    func doCreate() {
        contentTitle.text = "未加密"
        self.view.addSubview(contentTitle)
        
        contentTextView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
        contentTextView.layer.borderWidth = 1
        contentTextView.delegate = self
        self.view.addSubview(contentTextView)
        
        secureContentTitle.text = "加密"
        self.view.addSubview(secureContentTitle)
        
        secureContentTextView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
        secureContentTextView.layer.borderWidth = 1
        secureContentTextView.delegate = self
        self.view.addSubview(secureContentTextView)
    }
    
    func doLayout() {
        let screenWidth = UIScreen.main.bounds.width;
        
        contentTitle.frame = CGRect(x: (screenWidth-300)/2, y: 100, width: 100, height: 30)
        contentTextView.frame = CGRect(x: (screenWidth-300)/2+100, y: 100, width: 200, height: 30)
        secureContentTitle.frame = CGRect(x: (screenWidth-300)/2, y: 140, width: 100, height: 30)
        secureContentTextView.frame = CGRect(x: (screenWidth-300)/2+100, y: 140, width: 200, height: 30)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == contentTextView {
            content?.content = textView.text
            save()
        } else if textView == secureContentTextView {
            secureContent?.content = textView.text
            saveSecure()
        }
    }
}

extension ViewController {
    func save() {
        guard let unwrappedContent = content else {
            return
        }
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: unwrappedContent, requiringSecureCoding: false) else {
            return
        }
        NSLog("save content=%@", unwrappedContent.content)
        UserDefaults.standard.set(data, forKey: "content")
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: "content") else {
            content = Content()
            return
        }
        guard let unwrappedContent = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Content else {
            content = Content()
            return
        }
        content = unwrappedContent
    }
    
    func saveSecure() {
        guard let unwrappedContent = secureContent else {
            return
        }
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: unwrappedContent, requiringSecureCoding: true) else {
            return
        }
        NSLog("save contentsecure=%@", unwrappedContent.content)
        UserDefaults.standard.set(data, forKey: "contentsecure")
    }
    
    func loadSecure() {
        guard let data = UserDefaults.standard.data(forKey: "contentsecure") else {
            secureContent = SecureContent()
            return
        }
        guard let unwrappedContent = try? NSKeyedUnarchiver.unarchivedObject(ofClass: SecureContent.self, from: data) else {
            secureContent = SecureContent()
            return
        }
        secureContent = unwrappedContent
    }
}
