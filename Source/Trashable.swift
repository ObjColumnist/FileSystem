//
//  Trashable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `Trashable` `protocol` for an `Item` that can be trashed, on macOS the Item is moved to the Trash on iOS, tvOS and watchOS this is equivalent to the `Removeable` `protocol`.
public protocol Trashable: Item {
    mutating func trash() throws
}

extension Trashable {
    #if os(macOS)
    mutating public func trash() throws {
        var resultingURL: NSURL?
        try FileManager.default.trashItem(at: path.url, resultingItemURL: &resultingURL)
        self.path = Path(resultingURL as! URL)
    }
    #elseif os(iOS) || os(watchOS) || os(tvOS)
    mutating public func trash() throws {
        try FileManager.default.removeItem(at: path.url)
    }
    #endif
}
