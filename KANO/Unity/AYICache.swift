//
//  AYICache.swift
//  KANO
//
//  Created by 陳駿逸 on 2018/8/11.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit

final class AYICache {
    private var cache: NSCache<AnyObject, AnyObject>
    
    // MARK:- Initialization
    
    static let sharedCache = AYICache()
    
    private init() {
        self.cache = NSCache()
    }
    
    // MARK:- AYICache
    
    func clear() {
        cache.removeAllObjects()
    }
}
