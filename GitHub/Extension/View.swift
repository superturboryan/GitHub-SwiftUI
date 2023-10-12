//
//  View.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import SwiftUI

extension View {
    func size(_ size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
    
    func fullWidth(_ alignment: Alignment = .center) -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity, alignment: alignment)
    }
    
    func fullWidthAndHeight() -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}
