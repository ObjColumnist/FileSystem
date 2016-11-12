//
//  Parent.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Parent` `protocol` for an `Item` that can be a parent of another `Item`.
public protocol Parent: Item {
    /// Return the subitems for the instance of the conforming type.
    func subitems() throws -> [Subitem]
    /// Return if the instance of the conforming type is empty.
    func isEmpty() throws -> Bool
    /// Return if the instance of the conforming type contains the specified subitem.
    func contains(_ subitem: Subitem) throws -> Bool
}

extension Parent {
    /// Returns the subitems of the parent
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: All subitems contained in the parent.
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
    
    /// Returns wether the parent has 0 subitems.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A boolean to indicate if the parent is empty,
    public func isEmpty() throws -> Bool {
        return try subitems().isEmpty
    }
    
    /// Returns wether the parent contains the specified subitem.
    ///
    /// - parameter subitem: The submitem to check against.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A boolean to indicate if the parent contains the specified subitem.
    public func contains(_ subitem: Subitem) throws -> Bool {
        return try subitems().contains(where: { $0.path == subitem.path })
    }
}
