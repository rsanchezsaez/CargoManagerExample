//
//  CategoriesViewController.h
//

#import <UIKit/UIKit.h>

#import "StoreViewController.h"

@class CategoryElement;

@interface MainViewController : UIViewController < StoreDelegate, PopUpDelegate >

- (void)showStoreView;

@end


