//
//  StoreViewController.h
//

#import <UIKit/UIKit.h>

#import "PopUpViewController.h"
#import "CargoManager.h"

@protocol StoreDelegate;

@interface StoreViewController : PopUpViewController <CargoManagerUIDelegate>

@property (nonatomic, weak) id<StoreDelegate> delegate;

@end

@protocol StoreDelegate

- (void)storeDidFinishTransactionWithSuccess:(BOOL)success;

@end
