//
//  GameData.m
//

#import "GameData.h"

#import <StoreKit/StoreKit.h>

#import "CargoManager.h"

@interface StoreKitElement ()

@property (nonatomic) NSString *productIdentifier;
@property (nonatomic) NSString *imageName;
@property (nonatomic) int coinAmount;

@end

@implementation StoreKitElement

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    return [[[self class] alloc] initWithProductIdentifier:dictionary[@"productIdentifier"]
                                                coinAmount:[dictionary[@"coinAmount"] intValue]];
}

- (id)initWithProductIdentifier:(NSString *)productIdentifier
                     coinAmount:(int)coinAmount
{
    if ( !(self = [super init]) )
    {
        return nil;
    }
    
    self.productIdentifier = productIdentifier;
    self.coinAmount = coinAmount;
    
    return self;
}

- (SKProduct *)product
{
    return [[CargoManager sharedManager] productForIdentifier:self.productIdentifier];
}

@end


@interface GameData ()

@property (nonatomic) NSArray *storeKitElements;

@end

@implementation GameData

static GameData *_gameData = nil;

+ (GameData *)sharedData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      _gameData = [[GameData alloc] init];
                  });
    return _gameData;
}

- (id)init
{
    if ( _gameData )
    {
        return _gameData;
    }

    if ( !(self = [super init]) )
    {
        return nil;
    }

    self.storeKitElements = nil;
    
    [self loadGameData];
    
    return self;
}

- (void)loadGameData
{
    [self loadStoreKitElementsFromFile];
}

- (void)loadStoreKitElementsFromFile
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"storeKitElements" ofType:@"plist"];
    NSArray *plistArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];

    NSAssert(plistArray != nil, @"ERROR: Failed to load storeKitElements.plist.");

    if ( plistArray )
    {
        NSMutableArray *storeKitElements = [[NSMutableArray alloc] initWithCapacity:[plistArray count]];

        for ( NSDictionary* dictionary in plistArray )
        {
            StoreKitElement* storeKitProduct = [[StoreKitElement alloc] initWithDictionary:dictionary];
            [storeKitElements addObject:storeKitProduct];
        }

        // Storey inmutable copy
        self.storeKitElements = [storeKitElements copy];
    }
}

- (StoreKitElement *)storeKitElementForProductIdentifier:(NSString *)productIdentifier
{
    for (StoreKitElement *element in self.storeKitElements)
    {
        if ( [element.productIdentifier isEqualToString:productIdentifier] )
        {
            return element;
        }
    }
    return nil;
}

- (int)countOfStoreKitElements
{
    return [self.storeKitElements count];
}

#pragma mark - CargoManager StoreKitContentProviderDelegate

- (NSArray *)productIdentifiers
{
    NSMutableArray *productIdentifiers = [[NSMutableArray alloc] init];

    for (StoreKitElement *element in self.storeKitElements)
    {
        [productIdentifiers addObject:element.productIdentifier];
    }

    // Return a non-mutable copy
    return [NSArray arrayWithArray:productIdentifiers];
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier
{
    // Implement here the result of a successful IAP
    // on the corresponding productIdentifier
    StoreKitElement *storeKitElement = [self storeKitElementForProductIdentifier:productIdentifier];
    self.coinBalance += storeKitElement.coinAmount;    
}


@end
