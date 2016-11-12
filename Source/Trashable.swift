//
//  Trashable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Trashable` `protocol` for an `Item` that can be trashed on macOS.
@available(macOS 10.10, *)
public protocol Trashable: Item {
    #if os(macOS)
    /// Trashes the instance of the conforming type.
    mutating func trash() throws
    #endif
}

@available(macOS 10.10, *)
extension Trashable {
    #if os(macOS)
    /// Trash the `Item`.
    mutating public func trash() throws {
        var resultingURL: NSURL?
        try FileManager.default.trashItem(at: path.url, resultingItemURL: &resultingURL)
        self.path = Path(resultingURL as! URL)
    }
    #endif
}
