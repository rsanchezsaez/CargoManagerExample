//
//  GameData.h
//

#import <Foundation/Foundation.h>

#import "CargoManager.h"

@class SKProduct;

@interface StoreKitElement : NSObject

@property (nonatomic, readonly) NSString *productIdentifier;
@property (nonatomic, readonly) int coinAmount;

// This proerty gets the cached SKProduct from the CargoManager
@property (nonatomic, readonly) SKProduct *product;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithProductIdentifier:(NSString *)productIdentifier
                     coinAmount:(int)coinAmount;

@end


@interface GameData : NSObject <CargoManagerContentDelegate>

@property (nonatomic) int coinBalance;
@property (nonatomic, readonly) NSArray *storeKitElements;

+ (GameData *)sharedData;

- (void)loadStoreKitElementsFromFile;

@end

