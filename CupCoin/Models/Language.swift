

import Foundation

// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
let SET_LANGUAGE_KEY = "SetLanguages"
/// L102Language
class Language {
    
    /// get current Apple language
    class func currentAppleLanguage() -> String?{
        let userdef = UserDefaults.standard
        
        if let lang =  userdef.object(forKey: SET_LANGUAGE_KEY) as? String
        {
            return lang
        }
        else
        {
            let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
            let current = langArray.firstObject as? String
            return current
        }
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        
        let userdef = UserDefaults.standard
        userdef.set(lang, forKey: SET_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
    class func getString(_ str:String) -> String{
        
        return str.localize()
    }
    
    
}
