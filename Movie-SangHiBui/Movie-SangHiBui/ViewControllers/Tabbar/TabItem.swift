import UIKit

//CaseIterable dưới dạng thuộc tính mảng

enum TabItem: String, CaseIterable {
    case home = "Home"
    case favorite = "Favorite"
    case profile = "Profile"


    var icon: UIImage {
        switch self {
        case .home:
            return (UIImage(systemName: "house.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withRenderingMode(.alwaysOriginal))!
        case .favorite:
            return (UIImage(systemName: "list.and.film", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withRenderingMode(.alwaysOriginal))!
        case .profile:
            return (UIImage(systemName: "person.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withRenderingMode(.alwaysOriginal))!

        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
