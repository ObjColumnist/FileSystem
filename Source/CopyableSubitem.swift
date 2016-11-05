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
    public func copy(into parent: Parent) throws -> Self {
        let copyPath = parent.path.appendingComponent(path.lastComponent)
        return try copy(to: copyPath)
    }
}
