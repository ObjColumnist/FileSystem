//
//  File.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `File` is the base `protocol` for a single file.
public protocol File: Item, Subitem, Copyable, CopyableSubitem, Moveable, MoveableSubitem, Renameable, Removeable, Trashable, Linkable, SymbolicLinkable, Aliasable {}

extension File {
    /// Returns wether the contents of the specified files are equal.
    public func isContentEqual(to file: Self) -> Bool {
        return FileManager.default.contentsEqual(atPath: path.rawValue, andPath: file.path.rawValue)
    }
}
