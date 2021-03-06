@protocol MZEContentModule;
@class MZEContentModuleContainerViewController;

@protocol MZEContentModuleContainerViewControllerDelegate <NSObject>
- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)arg1 didCloseExpandedModule:(id <MZEContentModule>)arg2;
- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)arg1 willCloseExpandedModule:(id <MZEContentModule>)arg2;
- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)arg1 didOpenExpandedModule:(id <MZEContentModule>)arg2;
- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)arg1 willOpenExpandedModule:(id <MZEContentModule>)arg2;
- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)arg1 didFinishInteractionWithModule:(id <MZEContentModule>)arg2;
- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)arg1 didBeginInteractionWithModule:(id <MZEContentModule>)arg2;
- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)containerViewController openExpandedModule:(id <MZEContentModule>)expandedModule;
- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)containerViewController closeExpandedModule:(id <MZEContentModule>)expandedModule;
//- (void)contentModuleContainerViewController:(MZEContentModuleContainerViewController *)containerViewController closeExpandedModule:(id <MZEContentModule>)expandedModule withCompletion:(void(^)(void))completionBlock;
- (CGRect)compactModeFrameForContentModuleContainerViewController:(MZEContentModuleContainerViewController *)arg1;
- (BOOL)isLandscape;
@end