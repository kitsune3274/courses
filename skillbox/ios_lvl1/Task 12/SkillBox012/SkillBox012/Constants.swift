import UIKit

enum Constants {
    // цвета
    enum Colors {
        // "дорога"
        static var ColorRoad : UIColor? {
            UIColor (named: "ColorRoad")
        }
        // "отдых"
        static var ColorRest : UIColor? {
            UIColor (named: "ColorRest")
        }
        static var ColorPrepare: UIColor? {
            UIColor (named: "ColorPrepare")
        }
        // текст "start" и кнопка "stop"
        static var ColorStart : UIColor? {
            UIColor (named: "ColorStart")
        }
        // текст "stop" и кнопка "start"
        static var ColorStop : UIColor? {
            UIColor (named: "ColorStop")
        }
        // "wait"
        static var ColorWait: UIColor? {
            UIColor (named: "ColorWait")
        }
        // button "wait"
        static var ColorWaitButton: UIColor? {
            UIColor (named: "ColorWaitButton")
        }
    }
    // стили текста
    enum Fonts {
        static var JuraBold36: UIFont? {
            UIFont (name: "Jura-Bold", size: 36)
        }
        static var PacificoRegular24: UIFont? {
            UIFont (name: "Pacifico-Regular", size: 24)
        }
        static var KnewaveRegular24: UIFont? {
            UIFont (name: "Knewave-Regular", size: 24)
        }
    }
    
    // изображения
    enum Images {
        static let cart = UIImage (named: "cart")
        static let airplane = UIImage (named: "airplane")
        static let umbrella = UIImage (named: "umbrella")
        static let cartBordered = UIImage (named: "cartBordered")
        static let airplaneBordered = UIImage (named: "airplaneBordered")
    }
    
}
