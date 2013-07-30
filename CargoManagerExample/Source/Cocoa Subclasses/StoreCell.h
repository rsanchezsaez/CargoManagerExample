//
//  CategoryCell.h
//

#import <UIKit/UIKit.h>

@class TrophyLabel;
@class StoreKitElement;

@interface StoreCell : UITableViewCell

@property (nonatomic) StoreKitElement *storeKitElement;

- (void)endInitialLoadingStateWithError:(BOOL)error;

@end
