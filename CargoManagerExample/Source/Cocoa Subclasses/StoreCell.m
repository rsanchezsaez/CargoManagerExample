//
//  CategoryCell.m
//

#import "StoreCell.h"

#import <StoreKit/StoreKit.h>

#import "HighlightButton.h"

#import "Shared.h"
#import "GameData.h"

@class HighlightButton;

@interface StoreCell ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *storeErrorLabel;
@property (weak, nonatomic) IBOutlet HighlightButton *highlightButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic) UIImageView *bestValueView;

- (IBAction)touchedCell:(id)sender;

@end

@implementation StoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( !(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) )
    {
        return nil;
    }
    
    [self setupInternals];
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setupInternals];
}

- (void)setupInternals
{    
    // Does not actually load anything,
    // just shows the loading activity indicator
    [self showInitialLoadingState];
}

- (void)showInitialLoadingState
{
    self.imageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.priceLabel.hidden = YES;
    self.storeErrorLabel.hidden = YES;

    [self showActivityIndicator];
    self.userInteractionEnabled = NO;
}

- (void)endInitialLoadingStateWithError:(BOOL)error
{
    [self hideActivityIndicator];
    
    if (!error)
    {
        self.bestValueView.hidden = NO;

        self.imageView.hidden = NO;
        self.nameLabel.hidden = NO;
        self.priceLabel.hidden = NO;

        self.overlayView.hidden = YES;
        
        self.userInteractionEnabled = YES;
    }
    else
    {
        self.storeErrorLabel.hidden = NO;
    }
}

- (void)showActivityIndicator
{
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
}

- (void)hideActivityIndicator
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}


- (void)setStoreKitElement:(StoreKitElement *)storeKitElement
{
    _storeKitElement = storeKitElement;
    [self updateVisuals];
}

- (void)updateVisuals
{
    self.storeErrorLabel.hidden = YES;

    self.highlightButton.forceHighlight = NO;
    self.highlightButton.highlighted = NO;

    SKProduct *product = self.storeKitElement.product;

    self.nameLabel.text = formatInt(self.storeKitElement.coinAmount);
    self.priceLabel.text = product.localizedPrice;

    // If got products from Apple's StoreKit server
    // disable loading view
    if ( [CargoManager sharedManager].productRequestDidReceiveResponse )
    {
        [self endInitialLoadingStateWithError:
         ( [CargoManager sharedManager].productRequestError || !product )];
    }
}


- (IBAction)touchedCell:(id)sender {
    DLog(@"IAP: %@", self.storeKitElement.productIdentifier)

    [[CargoManager sharedManager] buyProduct:self.storeKitElement.product];
    
    self.superview.userInteractionEnabled = NO;

    // Keep the button higlighted
    self.highlightButton.forceHighlight = YES;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self showActivityIndicator];
}

@end
