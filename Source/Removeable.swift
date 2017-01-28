//
//  Removeable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Renameable` `protocol` for an `Item` that can be removed.
public protocol Removeable: Item {
    /// Removes the instance of the conforming type.
    func remove() throws
}

extension Removeable {
    /// Remove the `Item`.
    ///
    /// - note: This function removes the item instantly.
    ///
    /// - throws: An `Error`.
    public func remove() throws {
        try FileManager.default.removeItem(at: path.url)
    }
}
