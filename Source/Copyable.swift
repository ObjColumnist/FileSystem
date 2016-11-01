//
//  Copyable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 23/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol Copyable: Item {
    func copy(to path: Path) throws -> Self
}

extension Copyable {
    public func copy(to path: Path) throws -> Self {
        try FileManager.default.copyItem(at: self.path.url, to: path.url)
        return path.item! as! Self
    }
}
