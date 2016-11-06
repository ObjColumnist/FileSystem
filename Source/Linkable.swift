//
//  Linkable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Linkable` `protocol` for an `Item` that can be hard linked to a `Path`.
public protocol Linkable: Item {
    func link(to path: Path) throws -> Linkable
}

extension Linkable {
    /// Link the `Item` to the specified `Path`.
    ///
    /// - parameter path: The path to link too.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: the created `Linkable`.
    public func link(to path: Path) throws -> Linkable {
        try FileManager.default.linkItem(at: self.path.url, to: path.url)
        return path.item as! Linkable
    }
}
