import UIKit
import Social
import Flutter
import MobileCoreServices

open class RofaShareViewController: SLComposeServiceViewController, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
    }
    
    
    public var bundleIdentifier: String? {
        guard let identifier = Bundle.main.bundleIdentifier else {
            return nil
        }
        return identifier + ".Share"
    }
    
    public var sharedKey: String = "SharedKey"
    
    public var sharedText: [String] = []
    public let urlContentType = kUTTypeURL as String
    
    public override func isContentValid() -> Bool {
        return true
    }

    public override func didSelectPost() {
        guard let extensionContext = extensionContext else {
            return
        }
        extensionContext.completeRequest(returningItems: [], completionHandler: nil)
    }

    public override func configurationItems() -> [Any]! {
        return []
    }

}
