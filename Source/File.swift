//
//  File.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public protocol File: Item, Subitem, Copyable, CopyableSubitem, Moveable, MoveableSubitem, Renameable, Removeable, Trashable, Linkable, SymbolicLinkable {}

extension File {
    public func contents() throws -> Data? {
        return FileManager.default.contents(atPath: path.rawValue)
    }
    
    public func size() throws -> Int {
        let values = try path.url.resourceValues(forKeys: [.fileSizeKey])
        return values.fileSize!
    }
    
    public func isContentEqual(to file: Self) -> Bool {
        return FileManager.default.contentsEqual(atPath: path.rawValue, andPath: file.path.rawValue)
    }
}
