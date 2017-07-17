
#import "MZEModuleMetadata.h"

@interface MZEModuleRepository : NSObject {
	NSArray *_directoryURLs;
	NSMutableArray *_enabledIdentifiers;
	NSMutableArray *_disabledIdentifiers;
	NSMutableDictionary<MZEModuleMetadata *> *_moduleMetadataByIdentifier;
	NSString *_enabledKey;
	NSString *_disabledKey;
	NSString *_settingsIdentifier;
	NSString *_settingsFilePath;
}
@property (nonatomic, retain, readwrite) NSArray *directoryURLs;
@property (nonatomic, retain, readwrite) NSMutableArray *enabledIdentifiers;
@property (nonatomic, retain, readwrite) NSMutableArray *disabledIdentifiers;
@property (nonatomic, retain, readwrite) NSMutableDictionary<MZEModuleMetadata *> *moduleMetadataByIdentifier;
+ (instancetype)repositoryWithDefaults;
+ (NSArray *)_defaultModuleDirectories;
+ (NSString *)settingsFilePath;
+ (NSString *)settingsIdentifier;
+ (NSString *)enabledKey;
+ (NSString *)disabledKey;
+ (NSArray *)defaultEnabledIdentifiers;
- (id)_initWithDirectoryURLs:(NSArray *)directoryURLs;
- (void)updateAllModuleMetadata;
- (void)loadSettings;
- (void)reloadSettings;
@end