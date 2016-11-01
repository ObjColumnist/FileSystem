//
//  Renameable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol Renameable: Item {
    mutating func rename(to name: String) throws
}

extension Renameable {
    mutating public func rename(to name: String) throws {
        try FileManager.default.moveItem(at: path.url, to: path.replacingLastComponent(with: name).url)
        self.path = path
    }
}
