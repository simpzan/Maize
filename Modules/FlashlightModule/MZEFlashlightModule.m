#import "MZEFlashlightModule.h"
#import "MZEFlashlightModuleViewController.h"
#import <UIKit/UIColor+Private.h>
#import <UIKit/UIImage+Private.h>
#import <AVFoundation/AVFlashlight.h>

#define flashlight ((AVFlashlight *)[NSClassFromString(@"AVFlashlight") mze_sharedFlashlight])

@implementation MZEFlashlightModule

- (UIViewController *)backgroundViewController {
	if (!_backgroundViewController) {
		_backgroundViewController = [[MZESliderModuleBackgroundViewController alloc] initWithNibName:nil bundle:nil];
    	[_backgroundViewController setGlyphImage:[self isSelected] ? [self selectedIconGlyph] : [self iconGlyph]];
	}
    return _backgroundViewController;
}


+ (BOOL)isSupported {
	return [NSClassFromString(@"AVFlashlight") hasFlashlight];
}

- (id)init {
	self = [super initWithSwitchIdentifier:@"com.a3tweaks.switch.flashlight"];
	if (self) {
		_moduleBundle = [NSBundle bundleForClass:[self class]];
	}
	return self;
}

- (UIImage *)iconGlyph {
	if (!_cachedIconGlyph) {
		_cachedIconGlyph = [[UIImage imageNamed:@"FlashlightOff" inBundle:_moduleBundle] _flatImageWithColor:[UIColor whiteColor]];
	}
	return _cachedIconGlyph;
}

- (UIImage *)selectedIconGlyph {
	if (!_cachedSelectedIconGlyph) {
		_cachedSelectedIconGlyph = [[UIImage imageNamed:@"FlashlightOn" inBundle:_moduleBundle] _flatImageWithColor:[UIColor whiteColor]];
	}
	return _cachedSelectedIconGlyph;
}

- (UIColor *)selectedColor {
	return [UIColor systemBlueColor];
}

- (BOOL)isSelected {
	return [flashlight flashlightLevel] > 0 ? YES : NO;
}

- (BOOL)isEnabled {
	return [flashlight isAvailable];
}

- (void)setSelected:(BOOL)isSelected {
	[_backgroundViewController setGlyphImage:isSelected ? [self selectedIconGlyph] : [self iconGlyph]];
	[_viewController setSelected:isSelected];
	return;
}

- (void)switchStateDidChange:(NSNotification *)notification {
	return;
	// if (_viewController) {
	// 	[(MZEFlashlightModuleViewController *)_viewController updateToggleState];
	// }
}

- (UIViewController<MZEContentModuleContentViewController> *)contentViewController {
	if (!_viewController) {
		_viewController = [MZEFlashlightModuleViewController sharedFlashlightModule];
		[_viewController setModule:self];
	}
	return _viewController;
}

@end