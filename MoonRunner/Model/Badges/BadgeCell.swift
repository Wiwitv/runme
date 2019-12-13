

import UIKit

// Afficher des informations sur un badge
// Déclaration  d'une variable d'état qui est le modèle de la cellule pour qu'on puisse la répéter à l'infini

class BadgeCell: UITableViewCell {
  
  @IBOutlet weak var badgeImageView: UIImageView!
  @IBOutlet weak var silverImageView: UIImageView!
  @IBOutlet weak var goldImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var earnedLabel: UILabel!
  
  var status: BadgeStatus! {
    didSet {
      configure()
    }
  }
  
  private let redLabel = #colorLiteral(red: 1, green: 0.07843137255, blue: 0.1725490196, alpha: 1)
  private let greenLabel = #colorLiteral(red: 0, green: 0.5725490196, blue: 0.3058823529, alpha: 1)
  private let badgeRotation = CGAffineTransform(rotationAngle: .pi / 8)
  
  // Configuration l'ffaichage des cellulles dans la vue

  private func configure() {
    silverImageView.isHidden = status.silver == nil
    goldImageView.isHidden = status.gold == nil
    if let earned = status.earned {
      nameLabel.text = status.badge.name
      nameLabel.textColor = greenLabel
      let dateEarned = FormatDisplay.date(earned.timestamp)
      earnedLabel.text = "Obtenu le: \(dateEarned)"
      earnedLabel.textColor = greenLabel
      badgeImageView.image = UIImage(named: status.badge.imageName)
      silverImageView.transform = badgeRotation
      goldImageView.transform = badgeRotation
      isUserInteractionEnabled = true
      accessoryType = .disclosureIndicator
    } else {
      nameLabel.text = "Débloquer pour voir"
      nameLabel.textColor = redLabel
      let formattedDistance = FormatDisplay.distance(status.badge.distance)
      earnedLabel.text = "Courir \(formattedDistance) pour l'obtenir"
      earnedLabel.textColor = redLabel
      badgeImageView.image = nil
      isUserInteractionEnabled = false
      accessoryType = .none
      selectionStyle = .none
    }
  }
}
