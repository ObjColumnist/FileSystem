//
//  Parent.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol Parent: Item {
    func subitems() throws -> [Subitem]
    func isEmpty() throws -> Bool
    func contains(_ subitem: Subitem) throws -> Bool
}

extension Parent {
    public func subitems() throws -> [Subitem] {
        var items: [Subitem] = []
        
        guard let lastPathComponents = FileManager.default.subpaths(atPath: path.rawValue) else {
            return items
        }
        
        for lastPathComponent in lastPathComponents {
            let itemPath = path.appendingComponent(lastPathComponent)
            
            if let item = itemPath.item as? Subitem {
                items.append(item)
            }
        }
        
        return items
    }
    
    public func isEmpty() throws -> Bool {
        return try subitems().isEmpty
    }
    
    public func contains(_ subitem: Subitem) throws -> Bool {
        return try subitems().contains(where: { $0.path == subitem.path })
    }
}
