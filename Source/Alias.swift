//
//  Alias.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public struct Alias: File {
    public var path: Path
    
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isAliasFileKey])
            
            if let isAliasFile = resourceValues.isAliasFile, isAliasFile {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    public init(_ path: Path) {
        self.path = path
    }
    
    public func destination() throws -> Item {
        let destinationURL = try NSURL(resolvingAliasFileAt: self.path.url, options: []) as URL
        if let destination = Path(destinationURL).item {
            return destination
        } else {
            throw URLError(.fileDoesNotExist)
        }
    }
}
