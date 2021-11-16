//
//  Section.swift
//  MilujiPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import SwiftUI

struct Section {
    let name: String
    let color: Color
    let tracks: [Track]
}

extension Section: Identifiable {
    var id: String { name }
}
