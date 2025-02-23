

import UIKit

extension UIImageView {
    // назначить цвет изображению
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
// изменить тип
extension NSAttributedString {
    func toAttributedString() -> AttributedString {
        return AttributedString(self)
    }
}
