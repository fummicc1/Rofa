import UIKit
import Social
import Flutter
import MobileCoreServices

public enum RofaReceiveMethodName {
    case handleOverrideMethod(RofaOverrideMethod)
    case getText
    case getDeepLink
    case getCustomScheme
    
    var identifier: String {
        switch self {
        case .getText:
            return "getText"
        case .getDeepLink:
            return "getDeepLink"
        case .getCustomScheme:
            return "getCustomScheme"
        case .handleOverrideMethod(let method):
            return method.identifier
        }
    }
}


public enum RofaSendMethodName: String {
    
    case getDeepLink
    case getCustomScheme
    
    var identifier: String {
        rawValue
    }
}


public enum RofaOverrideMethod: String {
    case isContentValid
    case didSelectPost
    case configurationItems
    
    var identifier: String {
        rawValue
    }
}

open class RofaShareViewController: SLComposeServiceViewController, FlutterPlugin {
    
    static let kMessageChannel: String = "rofa/messages"
    
    static let typeText = String(kUTTypeText)
    
    var channel: FlutterMethodChannel!
    
    /// Used to validate deepLink
    var appCustomScheme: String?
    var openableDeepLink: String?
    
    // Check call
    var isCalledGetDeepLink: Bool = false
    var isCalledGetCustomScheme: Bool = false
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        channel.invokeMethod(RofaSendMethodName.getDeepLink.identifier, arguments: nil)
        channel.invokeMethod(RofaSendMethodName.getCustomScheme.identifier, arguments: nil)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: kMessageChannel,
            binaryMessenger: registrar.messenger()
        )
        let share = RofaShareViewController()
        share.channel = channel
        
        registrar.addMethodCallDelegate(share, channel: channel)
        
        registrar.addApplicationDelegate(share)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        guard let args = call.arguments as? [Any] else {
            return
        }
        
        if call.method == RofaReceiveMethodName.getDeepLink.identifier {
            
            if let text = args.first as? String {
                openableDeepLink = text
                
                isCalledGetDeepLink = true
            }
        } else if call.method == RofaReceiveMethodName.getCustomScheme.identifier {
            
            if let text = args.first as? String {
                appCustomScheme = text
                
                isCalledGetCustomScheme = true
            }
            
        }
        
        if isCalledGetCustomScheme, isCalledGetDeepLink {
            openDeepLink()
        }
    }
    
    public func openDeepLink() {
        guard let deepLink = openableDeepLink else {
            assert(false, "No deepLink found")
            return
        }
        let components = URLComponents(string: deepLink)
        if let url = components?.url {
            extensionContext?.open(url, completionHandler: nil)
        }
    }

    public override func isContentValid() -> Bool {
        super.isContentValid()
    }

    public override func didSelectPost() {
        super.didSelectPost()
    }

    public override func configurationItems() -> [Any]! {
        return []
    }
    
    public func buildConfigrurationItem(
        title: String,
        value: String,
        handler: @escaping SLComposeSheetConfigurationItemTapHandler
    ) -> SLComposeSheetConfigurationItem {
        let item = SLComposeSheetConfigurationItem()!
        item.title = title
        item.value = value
        item.tapHandler = handler
        return item
    }
}

extension RofaShareViewController: UIApplicationDelegate {
    
}
