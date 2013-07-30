//
//  CategoriesViewController.m
//

#import "MainViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "Shared.h"
#import "GameData.h"

@interface MainViewController ()

@property (nonatomic, weak) StoreViewController *storeViewController;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

- (IBAction)openStore:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.balanceLabel.text = formatInt([GameData sharedData].coinBalance);

}

#pragma mark - StoreDelegate

- (void)showStoreView
{
    if ( !self.storeViewController )
    {

        // Add store controller
        UIStoryboard *sharedStoryboard = [UIStoryboard storyboardWithName:@"SharedStoryboard_iPhone" bundle:nil];
        self.storeViewController = (StoreViewController*)[sharedStoryboard
                                                          instantiateViewControllerWithIdentifier:@"StoreViewController"];
        [self.storeViewController setDelegate:self];
        [self.storeViewController setPopUpDelegate:self];

        [self addChildViewController:self.storeViewController];
        [self.view addSubview:self.storeViewController.view];
    }
}

- (void)storeClosed
{
    self.storeViewController = nil;
}

- (void)storeDidFinishTransactionWithSuccess:(BOOL)success
{
    if (success)
    {
        self.balanceLabel.text = formatInt([GameData sharedData].coinBalance);
    }
}

- (void)openStore:(id)sender
{
    [self showStoreView];
}

#pragma mark - PopUpDelegate

- (void)popUpDidClose:(UIViewController *)sender
{
    if ( [sender isKindOfClass:[StoreViewController class]] )
    {
        self.storeViewController = nil;
    }
}

- (void)viewDidUnload {
    [self setBalanceLabel:nil];
    [super viewDidUnload];
}
@end

