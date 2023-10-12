//
//  LinearGradient.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import SwiftUI

extension LinearGradient {
    
    @ViewBuilder
    static var ghColors: LinearGradient {
        let randomizedColors: [Color] = [.ghBlue, .ghGreen, .ghRed, .ghOrange, .ghPurple].shuffled()
        let stops = [
            Gradient.Stop.init(color: randomizedColors[0], location: 0),
            Gradient.Stop.init(color: randomizedColors[1], location: 0.5),
            Gradient.Stop.init(color: randomizedColors[2], location: 1.0),
        ]
        LinearGradient(
            gradient: Gradient(stops: stops),
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
}
