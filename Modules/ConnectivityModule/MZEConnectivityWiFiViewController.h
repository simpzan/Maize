#import "MZEConnectivityButtonViewController.h"
#import <UIKit/UIImage+Private.h>
#import <UIKit/UIColor+Private.h>

@interface MZEConnectivityWiFiViewController : MZEConnectivityButtonViewController {
    NSBundle *_bundle;
    BOOL _isWAPI;
    UILongPressGestureRecognizer *_longPressRecognizer;
}

@property (nonatomic, retain, readwrite) UILongPressGestureRecognizer *longPressRecognizer;

+ (BOOL)isSupported;

- (id)init;
- (int)_currentState;
- (void)buttonTapped:(UIControl *)button;
- (NSString *)displayName;
- (void)viewDidLoad;
- (void)_updateState;
- (BOOL)_toggleState;
- (BOOL)_enabledForState:(int)state;
- (BOOL)_inoperativeForState:(int)state;
- (NSString *)_glyphStateForState:(int)state;
- (void)_beginObservingStateChanges;
- (void)_stopObservingStateChanges;
- (void)willBecomeActive;
- (void)willResignActive;
+ (BOOL)isSupported;
- (void)_pressed:(UILongPressGestureRecognizer *)sender;
- (void)getWiFiManager;
@end
