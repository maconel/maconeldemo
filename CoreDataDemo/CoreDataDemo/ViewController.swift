//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by maconelsun(孙炜) on 2018/8/29.
//  Copyright © 2018年 maconelsun(孙炜). All rights reserved.
//

import UIKit
import CoreData
import SnapKit

class ViewController: UIViewController {
    
    let dataTextField = UITextField()
    let okButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        doCreate()
        doLayout()
        load()
    }
    
    func doCreate() {
        dataTextField.borderStyle = .bezel
        view.addSubview(dataTextField)
        
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(onOkButtonTouchUpInside(sender:)), for: .touchUpInside)
        view.addSubview(okButton)
    }
    
    func doLayout() {
        dataTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
        
        okButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dataTextField.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
    }
    
    @objc func onOkButtonTouchUpInside(sender: UIButton) {
        save()
    }
    
    func load() {
        guard let context = getCDContext() else {
            return
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            guard let results = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                return
            }
            for r in results {
                dataTextField.text = r.value(forKey: "name") as? String
            }
        } catch {
            return
        }
    }
    
    func save() {
        guard let context = getCDContext() else {
            return
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: context) else {
            return
        }
        let person = NSManagedObject(entity: entity, insertInto: context)
        person.setValue(dataTextField.text, forKey: "name")
        do {
            try context.save()
        } catch {
            return
        }
    }
    
    func getCDContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
}
