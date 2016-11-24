//
//  UBahnLine.swift
//  CollectionViewSyncBehaviour
//
//  Created by Richard Nees on 31/10/2016.
//  Copyright © 2016 VIMN. All rights reserved.
//

import UIKit

struct UBahnLine {
    let name: String
    let route: (String, String)
    let color: UIColor
    let textColor: UIColor
    
    init(name: String, route: (String, String), color: UIColor, textColor: UIColor) {
        self.name = name
        self.route = route
        self.color = color
        self.textColor = textColor
    }
}

extension UBahnLine {
    
    static var all: [UBahnLine] {
        var all: [UBahnLine] = []
        all.append(UBahnLine(
            name: "U1",
            route: ("Uhlandstraße", "Warschauer Straße"),
            color: UIColor(red: 0.212, green:0.522, blue:0.125, alpha:1),
            textColor: UIColor.white))
        all.append(UBahnLine(
            name: "U2",
            route: ("Ruhleben", "Pankow"),
            color: UIColor(red: 0.894, green:0.145, blue:0.067, alpha:1),
            textColor: UIColor.white))
        all.append(UBahnLine(
            name: "U3",
            route: ("Krumme Lanke", "Nollendorfplatz"),
            color: UIColor(red: 0.039, green:0.314, blue:0.208, alpha:1),
            textColor: UIColor.white))
        all.append(UBahnLine(
            name: "U4",
            route: ("Innsbruckerplatz", "Nollendorfplatz"),
            color: UIColor(red: 0.992, green:0.714, blue:0.039, alpha:1),
            textColor: UIColor.black))
        all.append(UBahnLine(
            name: "U5",
            route: ("Alexanderplatz", "Hönow"),
            color: UIColor(red: 0.302, green:0.173, blue:0.129, alpha:1),
            textColor: UIColor.white))
        all.append(UBahnLine(
            name: "U6",
            route: ("Tegel", "Alt-Mariendorf"),
            color: UIColor(red: 0.475, green:0.341, blue:0.604, alpha:1),
            textColor: UIColor.white))
        all.append(UBahnLine(
            name: "U7",
            route: ("Rathaus Spandau", "Rudow"),
            color: UIColor(red: 0.263, green:0.478, blue:0.671, alpha:1),
            textColor: UIColor.white))
        all.append(UBahnLine(
            name: "U8",
            route: ("Wittenau", "Hermannstraße"),
            color: UIColor(red: 0.016, green:0.184, blue:0.384, alpha:1),
            textColor: UIColor.white))
        all.append(UBahnLine(
            name: "U9",
            route: ("Osloer Straße", "Rathaus Steglitz"),
            color: UIColor(red: 0.961, green:0.322, blue:0.075, alpha:1),
            textColor: UIColor.white))
        
        return all
    }
}
