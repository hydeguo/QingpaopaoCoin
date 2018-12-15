

import Foundation
import UIKit

class Localizer: NSObject {
    class func DoTheSwizzling() {
        // 1
    MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector:#selector(Bundle.localizedString(forKey:value:table:)),overrideSelector:#selector(Bundle.specialLocalizedStringForKey(key:value:table:)))
        
    MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector:#selector(getter: UIApplication.userInterfaceLayoutDirection),overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
    
    }
}

extension UIApplication {
    @objc var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if Language.currentAppleLanguage() == "ar" {
                direction = .rightToLeft
            }
            return direction
        }
    }
}

extension String {
    
    func localize() ->String {

        let currentLanguage = Language.currentAppleLanguage()
        var bundle = Bundle();
        /*3*/if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
       
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
}


extension Bundle {
    
   @objc func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        
        let currentLanguage = Language.currentAppleLanguage()
        var bundle = Bundle();
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
    }

    static func localizedBundle() -> Bundle {
        
        let currentLanguage = Language.currentAppleLanguage()
        var bundle = Bundle();
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        return bundle
    }
}

/// Exchange the implementation of two methods for the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector:Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
