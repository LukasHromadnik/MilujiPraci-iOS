//
//  Track.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 27/02/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

enum TrackType {
    case basic
    case extra
    case milos

    var backgroundColor: UIColor {
        switch self {
        case .basic: return .mainGreen
        case .extra: return .mainGreen
        case .milos: return .mainPink
        }
    }
}

struct Track {
    let title: String
    let filename: String
    let type: TrackType
}

extension Track {

    var fileURL: URL? {
        return Bundle.main.url(forResource: filename, withExtension: nil)
    }

}

extension Track {

    static let allBasic: [Track] = [
        Track(title: "Ani za kokot vole!", filename: "ani-za-kokot-vole.mp3", type: .basic),
        Track(title: "Do piče!", filename: "do-pice.mp3", type: .basic),
        Track(title: "Hajzli jedni!", filename: "hajzli-jedni.mp3", type: .basic),
        Track(title: "Hoši, toto je neuvěřitelné!", filename: "hosi-to-je-neuveritelne.mp3", type: .basic),
        Track(title: "Já se z toho musím pojebat!", filename: "ja-se-z-toho-musim-pojebat.mp3", type: .basic),
        Track(title: "Já to mrdám!", filename: "ja-to-mrdam.mp3", type: .basic),
        Track(title: "Jedinou pičovinku!", filename: "jedinou-picovinku.mp3", type: .basic),
        Track(title: "Jedu do piči!", filename: "jedu-do-pici-stadyma.mp3", type: .basic),
        Track(title: "KURVA!", filename: "kurva.mp3", type: .basic),
        Track(title: "To není možné!", filename: "kurva-do-pice-to-neni-mozne.mp3", type: .basic),
        Track(title: "Nebudu to dělat!", filename: "nebudu-to-delat.mp3", type: .basic),
        Track(title: "Past vedle pasti!", filename: "past-vedle-pasti-pico.mp3", type: .basic),
        Track(title: "To je nemožné!", filename: "to-je-pico-nemozne.mp3", type: .basic),
        Track(title: "To není normální!", filename: "to-neni-normalni-kurva.mp3", type: .basic),
        Track(title: "To sou nervy ty pičo!", filename: "to-sou-nervy-ty-pico.mp3", type: .basic)
    ]

    static let allExtra: [Track] = [
        Track(title: "Abys mohl toto!", filename: "abych-mohl-toto.mp3", type: .extra),
        Track(title: "Ani očko nenasadíš!", filename: "ani-ocko-nenasadis.mp3", type: .extra),
        Track(title: "Banální věc!", filename: "banalni-vec.mp3", type: .extra),
        Track(title: "Já to nejdu dělat!", filename: "ja-to-nejdu-delat.mp3", type: .extra),
        Track(title: "Kurva už!", filename: "kurva-uz.mp3", type: .extra),
        Track(title: "Ne, nenasadíš ho!", filename: "ne-nenasadis-ho.mp3", type: .extra),
        Track(title: "Největší blbec na zeměkouli!", filename: "nejvetsi-blbec-na-zemekouli.mp3", type: .extra),
        Track(title: "Nenasadím!", filename: "nenasadim.mp3", type: .extra),
        Track(title: "Nerešitelný problém hoši!", filename: "neresitelny-problem-hosi.mp3", type: .extra),
        Track(title: "Nevím jak!", filename: "nevim-jak.mp3", type: .extra),
        Track(title: "Okamžitě zabít ty kurvy!", filename: "okamzite-zabit-ty-kurvy.mp3", type: .extra),
        Track(title: "Počkej kámo!", filename: "pockej-kamo.mp3", type: .extra),
        Track(title: "Tady musíš všechno rozdělat!", filename: "tady-musis-vsechno-rozdelat.mp3", type: .extra),
        Track(title: "Tuto piču potřebuju utáhnout!", filename: "tuto-picu-potrebuju-utahnout.mp3", type: .extra),
        Track(title: "Zasrané, zamrdané!", filename: "zasrane-zamrdane.mp3", type: .extra)
    ]

    static let allMilos: [Track] = [
        Track(title: "Hovno", filename: "hovno.mp3", type: .milos),
        Track(title: "Zkurvila", filename: "zkurvila.mp3", type: .milos),
        Track(title: "Kurev", filename: "kurev.mp3", type: .milos),
        Track(title: "Kunda sem", filename: "kunda-sem.mp3", type: .milos),
        Track(title: "Kunda", filename: "kunda.mp3", type: .milos),
        Track(title: "Kunda tam", filename: "kunda-tam.mp3", type: .milos)
    ]
}
