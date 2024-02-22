
import Foundation

class UserDefaultsManager {
    private let key = "SavedText"
    
    func save(text: String) {
        UserDefaults.standard.set(text, forKey: key)
    }
    
    func load() -> String {
        UserDefaults.standard.string(forKey: key) ?? ""
    }
}
