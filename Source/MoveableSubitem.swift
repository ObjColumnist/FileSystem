//
//  MoveableSubitem.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `MoveableSubitem` `protocol` for an `Item` that adopts `Moveable` and `Subitem`.
public protocol MoveableSubitem: Moveable, Subitem {
    mutating func move(into parent: Parent) throws
}

extension MoveableSubitem {
    /// Move the `Item` into the specified `Parent`.
    ///
    /// - parameter parent: The parent to move the item into.
    ///
    /// - throws: An `Error`.
    mutating public func move(into parent: Parent) throws {
        let movePath = parent.path.appendingComponent(path.lastComponent)
        try move(to: movePath)
    }
}
