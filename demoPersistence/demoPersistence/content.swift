//
//  content.swift
//  demoPersistence
//
//  Created by maconelsun(孙炜) on 2018/8/13.
//  Copyright © 2018年 maconelsun(孙炜). All rights reserved.
//

import Foundation

class Content: NSObject {
    var content: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        if let content = aDecoder.decodeObject(forKey: "content") as? String {
            self.content = content
        }
    }
    
    override init() {
        super.init()
    }
}

extension Content: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(content, forKey: "content")
    }
}



class SecureContent: NSObject {
    var content: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        if let content = aDecoder.decodeObject(forKey: "content") as? String {
            self.content = content
        }
    }
    
    override init() {
        super.init()
    }
}

extension SecureContent: NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(content, forKey: "content")
    }
}
