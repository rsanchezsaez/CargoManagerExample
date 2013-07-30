//
//  PopUpViewController.h
//

#import <UIKit/UIKit.h>

@protocol PopUpDelegate;

@interface PopUpViewController : UIViewController

@property (nonatomic,weak) id<PopUpDelegate> popUpDelegate;
@property (nonatomic, weak) UIView *overlayBackground;

- (void)close;

- (void)addBackground;
- (void)removeBackground;

@end


@protocol PopUpDelegate <NSObject>

- (void)popUpDidClose:(UIViewController *)sender;

@optional

@end
