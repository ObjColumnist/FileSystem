//
//  PathRepresentable.swift
//  FileSystem
//
//  Created by Spencer MacDonald on 21/09/2016.
//  Copyright © 2016 Square Bracket Software. All rights reserved.
//

import Foundation

/// `PathRepresentable` can be adopted by anything that can be represented by a `Path`.
public protocol PathRepresentable {
    /// The path that is being represented by the instance of the conforming type.
    var path: Path { get }
    
    /// Instantiates an instance of the conforming type from a path representation, can fail if the path is an invalid representation by the conforming type.
    init?(path: Path)
}
