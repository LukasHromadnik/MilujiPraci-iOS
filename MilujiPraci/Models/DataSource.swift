//
//  DataSource.swift
//  MilujiPraci
//
//  Created by Lukáš Hromadník on 01/05/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

enum DataSource {

    static let sections: [Section] = [.basic, .extra, .milos]

    // swiftlint:disable:next function_body_length
    static func tracks(for section: Section) -> [Track] {
        switch section {
        case .basic:
            return [
                Track(title: "Ani za kokot vole!", filename: "ani-za-kokot-vole.mp3"),
                Track(title: "Do piče!", filename: "do-pice.mp3"),
                Track(title: "Hajzli jedni!", filename: "hajzli-jedni.mp3"),
                Track(title: "Hoši, toto je neuvěřitelné!", filename: "hosi-to-je-neuveritelne.mp3"),
                Track(title: "Já se z toho musím pojebat!", filename: "ja-se-z-toho-musim-pojebat.mp3"),
                Track(title: "Já to mrdám!", filename: "ja-to-mrdam.mp3"),
                Track(title: "Jedinou pičovinku!", filename: "jedinou-picovinku.mp3"),
                Track(title: "Jedu do piči!", filename: "jedu-do-pici-stadyma.mp3"),
                Track(title: "KURVA!", filename: "kurva.mp3"),
                Track(title: "To není možné!", filename: "kurva-do-pice-to-neni-mozne.mp3"),
                Track(title: "Nebudu to dělat!", filename: "nebudu-to-delat.mp3"),
                Track(title: "Past vedle pasti!", filename: "past-vedle-pasti-pico.mp3"),
                Track(title: "To je nemožné!", filename: "to-je-pico-nemozne.mp3"),
                Track(title: "To není normální!", filename: "to-neni-normalni-kurva.mp3"),
                Track(title: "To sou nervy ty pičo!", filename: "to-sou-nervy-ty-pico.mp3")
            ]
        case .extra:
            return [
                Track(title: "Abys mohl toto!", filename: "abych-mohl-toto.mp3"),
                Track(title: "Ani očko nenasadíš!", filename: "ani-ocko-nenasadis.mp3"),
                Track(title: "Banální věc!", filename: "banalni-vec.mp3"),
                Track(title: "Já to nejdu dělat!", filename: "ja-to-nejdu-delat.mp3"),
                Track(title: "Kurva už!", filename: "kurva-uz.mp3"),
                Track(title: "Ne, nenasadíš ho!", filename: "ne-nenasadis-ho.mp3"),
                Track(title: "Největší blbec na zeměkouli!", filename: "nejvetsi-blbec-na-zemekouli.mp3"),
                Track(title: "Nenasadím!", filename: "nenasadim.mp3"),
                Track(title: "Nerešitelný problém hoši!", filename: "neresitelny-problem-hosi.mp3"),
                Track(title: "Nevím jak!", filename: "nevim-jak.mp3"),
                Track(title: "Okamžitě zabít ty kurvy!", filename: "okamzite-zabit-ty-kurvy.mp3"),
                Track(title: "Počkej kámo!", filename: "pockej-kamo.mp3"),
                Track(title: "Tady musíš všechno rozdělat!", filename: "tady-musis-vsechno-rozdelat.mp3"),
                Track(title: "Tuto piču potřebuju utáhnout!", filename: "tuto-picu-potrebuju-utahnout.mp3"),
                Track(title: "Zasrané, zamrdané!", filename: "zasrane-zamrdane.mp3")
            ]
        case .milos:
            return [
                Track(title: "Hovno", filename: "hovno.mp3"),
                Track(title: "Zkurvila", filename: "zkurvila.mp3"),
                Track(title: "Kurev", filename: "kurev.mp3"),
                Track(title: "Kunda sem", filename: "kunda-sem.mp3"),
                Track(title: "Kunda", filename: "kunda.mp3"),
                Track(title: "Kunda tam", filename: "kunda-tam.mp3")
            ]
        }
    }

}
