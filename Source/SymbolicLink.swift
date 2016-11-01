//
//  SymbolicLink.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public struct SymbolicLink: File {
    public var path: Path
    
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isSymbolicLinkKey])
            
            if let isSymbolicLink = resourceValues.isSymbolicLink, isSymbolicLink {
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
    
    public func destination() throws -> SymbolicLinkable {
        let destinationURL = try FileManager.default.destinationOfSymbolicLink(atPath: path.rawValue)
        if let destination = Path(destinationURL).item as? SymbolicLinkable {
            return destination
        } else {
            throw URLError(.fileDoesNotExist)
        }
    }
}
