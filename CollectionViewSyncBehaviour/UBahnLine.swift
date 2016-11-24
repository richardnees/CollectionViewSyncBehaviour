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
            color: #colorLiteral(red: 0.2105785012, green: 0.5224696994, blue: 0.1274542212, alpha: 1),
            textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        all.append(UBahnLine(
            name: "U2",
            route: ("Ruhleben", "Pankow"),
            color: #colorLiteral(red: 0.8923007846, green: 0.1446735561, blue: 0.06605774909, alpha: 1),
            textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        all.append(UBahnLine(
            name: "U3",
            route: ("Krumme Lanke", "Nollendorfplatz"),
            color: #colorLiteral(red: 0.03809330985, green: 0.3118835688, blue: 0.2092007399, alpha: 1),
            textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        all.append(UBahnLine(
            name: "U4",
            route: ("Innsbruckerplatz", "Nollendorfplatz"),
            color: #colorLiteral(red: 0.9907892346, green: 0.7140136361, blue: 0.04488366097, alpha: 1),
            textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
        all.append(UBahnLine(
            name: "U5",
            route: ("Alexanderplatz", "Hönow"),
            color: #colorLiteral(red: 0.3005996943, green: 0.1724930704, blue: 0.1286527514, alpha: 1),
            textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        all.append(UBahnLine(
            name: "U6",
            route: ("Tegel", "Alt-Mariendorf"),
            color: #colorLiteral(red: 0.4764931798, green: 0.3416231573, blue: 0.6026445031, alpha: 1),
            textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        all.append(UBahnLine(
            name: "U7",
            route: ("Rathaus Spandau", "Rudow"),
            color: #colorLiteral(red: 0.2647311985, green: 0.4788146615, blue: 0.6699940562, alpha: 1),
            textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        all.append(UBahnLine(
            name: "U8",
            route: ("Wittenau", "Hermannstraße"),
            color: #colorLiteral(red: 0.01452015899, green: 0.1829759479, blue: 0.3823931217, alpha: 1),
            textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        all.append(UBahnLine(
            name: "U9",
            route: ("Osloer Straße", "Rathaus Steglitz"),
            color: #colorLiteral(red: 0.9590007663, green: 0.321900785, blue: 0.07232486457, alpha: 1),
            textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        
        return all
    }
}
