//
//  Renameable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Renameable` `protocol` for an `Item` that can be renamed.
public protocol Renameable: Item {
    mutating func rename(to name: String) throws
}

extension Renameable {
    /// Rename the `Item` to the specified name.
    ///
    /// - parameter name: The new name of the item.
    ///
    /// - throws: An `Error`.
    mutating public func rename(to name: String) throws {
        try FileManager.default.moveItem(at: path.url, to: path.replacingLastComponent(with: name).url)
        self.path = path
    }
}
