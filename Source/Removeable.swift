//
//  Removeable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol Removeable: Item {
    func remove() throws
}

extension Removeable {
    public func remove() throws {
        try FileManager.default.removeItem(at: path.url)
    }
}
