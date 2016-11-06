//
//  Moveable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Moveable` `protocol` for an `Item` that can be moved to another `Path`.
public protocol Moveable: Item {
    mutating func move(to path: Path) throws
}

extension Moveable {
    /// Move the `Item` to the specified `Path`.
    ///
    /// - parameter path: The path to move the item too.
    ///
    /// - throws: An `Error`.
    mutating public func move(to path: Path) throws {
        try FileManager.default.moveItem(at: self.path.url, to: path.url)
        self.path = path
    }
}
