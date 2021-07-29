#import "RofaPlugin.h"
#if __has_include(<rofa/rofa-Swift.h>)
#import <rofa/rofa-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rofa-Swift.h"
#endif

@implementation RofaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [RofaShareViewController registerWithRegistrar:registrar];
}
@end
