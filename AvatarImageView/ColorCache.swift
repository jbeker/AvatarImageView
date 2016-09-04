//
//  ColorCache.swift
//  AvatarImageView
//
//  Created by Ayush Newatia on 15/08/2016.
//  Copyright © 2016 Ayush Newatia. All rights reserved.
//

import Foundation

final class ColorCache<ValueType: AnyObject> {
    
    fileprivate let cache: NSCache<ValueType,AnyObject> = NSCache<ValueType,AnyObject>()
    
    lazy var notificationCenter = NotificationCenter.default
    lazy var application = UIApplication.shared
    
    init() {
        notificationCenter.addObserver(self,
                                       selector: #selector(clear),
                                       name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning,
                                       object: application)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    subscript(key: ValueType) -> ValueType? {
        get {
            return cache.object(forKey: key) as? ValueType
        }
        set {
            if let value: ValueType = newValue {
                cache.setObject(value, forKey: key)
            }
            else {
                cache.removeObject(forKey: key)
            }
        }
    }
    
    @objc func clear() {
        cache.removeAllObjects()
    }
}
