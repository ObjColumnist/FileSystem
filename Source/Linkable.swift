//
//  Linkable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol Linkable: Item {
    func link(to path: Path) throws
}

extension Linkable {
    public func link(to path: Path) throws {
        try FileManager.default.linkItem(at: self.path.url, to: path.url)
    }
}
