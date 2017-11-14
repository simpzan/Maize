#import "MZEMediaModuleViewController.h"
#import <UIKit/UIImage+Private.h>

@implementation MZEMediaModuleViewController

- (id)initWithNibName:(id)arg1 bundle:(id)arg2 {
	self = [super initWithNibName:arg1 bundle:arg2];
	if (self) {
		self.metadataView = [[NSClassFromString(@"MZEMediaMetaDataView") alloc] initWithFrame:self.view.bounds];
		[self.view addSubview:self.metadataView];

		[self.metadataView.outputButton.toggleButton addTarget:self action:@selector(outputButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

		self.controlsView = [[NSClassFromString(@"MZEMediaControlsViewController") alloc] init];
		[self.view addSubview:self.controlsView.view];

	  [[NSNotificationCenter defaultCenter] addObserver:self
	    selector:@selector(updateMedia)
	    name:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDidChangeNotification
	    object:nil];

		_isExpanded = NO;
	}
	return self;
}

- (void)outputButtonPressed:(UIButton *)outputButton {
	if (self.controlsView.showRouting) {
		self.controlsView.showRouting = NO;
		[UIView animateWithDuration:0.3 animations:^{
			[self.view setNeedsLayout];
			[self.view layoutIfNeeded];
			[self.controlsView viewWillLayoutSubviews];
			UIImage *btnImage = [[UIImage imageNamed:@"AirPlay" inBundle:[NSBundle bundleForClass:[self class]]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  			[outputButton setImage:btnImage forState:UIControlStateNormal];
		} completion:^(BOOL completed) {
			[self.controlsView.routingView.routingViewController _endRouteDiscovery];
		}];

		// UIImage *btnImage = [[UIImage imageNamed:@"AirPlay" inBundle:[NSBundle bundleForClass:[self class]]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  // 		[outputButton setImage:btnImage forState:UIControlStateNormal];
		//[self.controlsView.routingView.routingViewController _endRouteDiscovery];
	} else {
		self.controlsView.showRouting = YES;
		[self.controlsView.routingView.routingViewController _beginRouteDiscovery];
		[UIView animateWithDuration:0.3 animations:^{
			[self.view setNeedsLayout];
			[self.view layoutIfNeeded];
			[self.controlsView viewWillLayoutSubviews];
			UIImage *btnImage = [[UIImage imageNamed:@"Play-Pause" inBundle:[NSBundle bundleForClass:[self class]]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  			[outputButton setImage:btnImage forState:UIControlStateNormal];
		} completion:^(BOOL completed) {

		}];
		// [self.view setNeedsLayout];
		// [self.view layoutIfNeeded];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.clipsToBounds = YES;
}

- (void)willBecomeActive {
	[self updateMedia];
}

- (void)willResignActive {
}

- (void)viewWillLayoutSubviews {
	if(_isExpanded){
		self.controlsView.view.frame = CGRectMake(0,self.view.frame.size.height/3.5, self.view.frame.size.width, self.view.frame.size.height - self.view.frame.size.height/3.5);
		self.metadataView.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height/3.5);

		self.controlsView.expanded = TRUE;
	} else {
		self.metadataView.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height/2);
		self.controlsView.view.frame = CGRectMake(0,self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);

		self.controlsView.expanded = FALSE;
	}

}

- (CGFloat)preferredExpandedContentWidth {
	CGSize containerSize = [[UIScreen mainScreen] _mainSceneBoundsForInterfaceOrientation:[UIDevice currentDevice].orientation].size;
	return [MZEMediaLayoutHelper widthForExpandedContainerWithContainerSize:containerSize defaultButtonSize:CGSizeMake(90,90)];
}

- (CGFloat)preferredExpandedContentHeight {
	if (!_prefferedContentExpandedHeight) {
		MPULayoutInterpolator *interpolator = [NSClassFromString(@"MPULayoutInterpolator") new];
		[interpolator addValue:403.5 forReferenceMetric:320];
		[interpolator addValue:417.5 forReferenceMetric:375];
		[interpolator addValue:455.5 forReferenceMetric:414];
		_prefferedContentExpandedHeight = [interpolator valueForReferenceMetric:[UIScreen mainScreen].bounds.size.width];
	}

	return _prefferedContentExpandedHeight - _prefferedContentExpandedHeight/8;
}

- (void)willTransitionToExpandedContentMode:(BOOL)expanded {
	_isExpanded = expanded;
	self.metadataView.expanded = expanded;
	self.controlsView.showRouting = NO;
	UIImage *btnImage = [[UIImage imageNamed:@"AirPlay" inBundle:[NSBundle bundleForClass:[self class]]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  	[self.metadataView.outputButton.toggleButton setImage:btnImage forState:UIControlStateNormal];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.view setNeedsLayout];
		[self.view layoutIfNeeded];
        // do whatever
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {

    }];

    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (BOOL)providesOwnPlatter {
	return NO;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
	return NO;
}
-(void)updateMedia {
	[self.controlsView updateMediaForChangeOfMediaControlsStatus];
	[self.metadataView updateMediaForChangeOfMediaControlsStatus];

	if([self.metadataView.titleLabel.label.text isEqualToString:@"IPHONE"]){
			self.controlsView.controlsView.skipButton.alpha = 0.16;
			self.controlsView.controlsView.rewindButton.alpha = 0.16;
			self.controlsView.hasTitles = FALSE;
	} else {
			self.controlsView.controlsView.skipButton.alpha = 0.8;
			self.controlsView.controlsView.rewindButton.alpha = 0.8;
			self.controlsView.hasTitles = TRUE;
	}
}
@end
