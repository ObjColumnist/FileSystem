//
//  Directory.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

public struct Directory: Item, Parent, Subitem, Copyable, CopyableSubitem, Moveable, MoveableSubitem, Renameable, Removeable, Trashable, SymbolicLinkable, FileWrapperConvertible {
    public var path: Path
    
    public init?(path: Path) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isDirectoryKey])
            
            if let isDirectory = resourceValues.isDirectory, isDirectory {
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
    
    @available(iOS 10.0, tvOS 10.0, watchOS 3.0, macOS 10.12, *)
    public static var temporary: Directory {
        let url = FileManager.default.temporaryDirectory
        return Directory(Path(url))
    }
    
    public static var document: Directory {
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return Directory(Path(documentUrl))
    }
    
    public static var library: Directory {
        let libraryUrl = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        return Directory(Path(libraryUrl))
    }
    
    public static var caches: Directory {
        let cachesUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return Directory(Path(cachesUrl))
    }
    
    public static var application: Directory {
        let applicationUrl = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first!
        return Directory(Path(applicationUrl))
    }
    
    public static var applicationSupport: Directory {
        let applicationSupportUrl = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        return Directory(Path(applicationSupportUrl))
    }
  
    public static var desktop: Directory {
        let desktopUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        return Directory(Path(desktopUrl))
    }
    
    public static var downloads: Directory {
        let downloadsUrl = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        return Directory(Path(downloadsUrl))
    }
    
    public static var movies: Directory {
        let moviesUrl = FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
        return Directory(Path(moviesUrl))
    }
  
    public static var music: Directory {
        let musicUrl = FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
        return Directory(Path(musicUrl))
    }
    
    public static var pictures: Directory {
        let picturesUrl = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first!
        return Directory(Path(picturesUrl))
    }
    
    public static var applications: [Directory] {
        let applicationUrls = FileManager.default.urls(for: .allApplicationsDirectory, in: .userDomainMask)
        return applicationUrls.map( { Directory(Path($0)) } )
    }
    
    public static var libraries: [Directory] {
        let libraryUrls = FileManager.default.urls(for: .allLibrariesDirectory, in: .userDomainMask)
        return libraryUrls.map( { Directory(Path($0)) } )
    }
    
    public static func create(at path: Path, withIntermediateDirectories: Bool = false) throws -> Directory {
        try FileManager.default.createDirectory(at: path.url, withIntermediateDirectories: withIntermediateDirectories, attributes: nil)
        return Directory(path)
    }
    
    public func relationship(to item: Item) throws -> FileManager.URLRelationship {
        var urlRelationship: FileManager.URLRelationship = .other
        try FileManager.default.getRelationship(&urlRelationship, ofDirectoryAt: path.url, toItemAt: item.path.url)
        return urlRelationship
    }
}

#if os(macOS)
extension Directory {
    @available(macOS 10.12, *)
    public static var home: Directory {
        let url = FileManager.default.homeDirectoryForCurrentUser
        return Directory(Path(url))
    }

    @available(macOS 10.12, *)
    public static func home(forUser user: String) -> Directory? {
        guard let url = FileManager.default.homeDirectory(forUser: user) else {
            return nil
        }
        return Directory(Path(url))
    }
}
#endif
