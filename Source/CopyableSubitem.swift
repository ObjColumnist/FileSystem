//
//  CopyableSubitem.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `CopyableSubitem` `protocol` for an `Item` that adopts `Copyable` and `Subitem`.
public protocol CopyableSubitem: Copyable, Subitem {
    func copy(into parent: Parent) throws -> Self
}

extension CopyableSubitem {
    /// Copy the `Item` into the the specified `Parent`.
    ///
    /// - parameter parent: The parent to copy the item into.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A copy of the item.
    public func copy(into parent: Parent) throws -> Self {
        let copyPath = parent.path.appendingComponent(path.lastComponent)
        return try copy(to: copyPath)
    }
}
