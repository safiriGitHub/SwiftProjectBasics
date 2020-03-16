//
//  NSUserDefaults+Extension.swift
//  ChildPediatric
//
//  Created by safiri on 2018/4/21.
//  Copyright © 2018年 safiri. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    func saveCustomObject(customObject object: NSCoding, forkey key: String) {
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
        self.set(encodedObject, forKey: key)
        self.synchronize()
    }
    
    func getCustomObject(forKey key: String) -> Any? {
        let decodedObject = self.object(forKey: key) as? Data
        if let decode = decodedObject {
            return NSKeyedUnarchiver.unarchiveObject(with: decode)
        }
        return nil
    }
}
