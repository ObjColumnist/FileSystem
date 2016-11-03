//
//  RegularFile.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/10/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public struct RegularFile: File, FileHandleConvertible, FileWrapperConvertible {
    public var path: Path
    
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isRegularFileKey])
            
            if let isRegularFile = resourceValues.isRegularFile, isRegularFile {
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
    
    public static func create(at path: Path) throws -> RegularFile {
        if FileManager.default.createFile(atPath: path.rawValue, contents: nil, attributes: nil) {
            return RegularFile(path)
        } else {
            throw URLError(.cannotCreateFile)
        }
    }
}
