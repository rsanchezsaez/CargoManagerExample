//
//  StoreViewController.m
//

#import "StoreViewController.h"

#import <StoreKit/StoreKit.h>

#import "StoreCell.h"

#import "Shared.h"

#import "CargoManager.h"
#import "GameData.h"

@interface StoreViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)touchedCloseButton:(id)sender;

@end

@implementation StoreViewController {
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Register to notification to update store
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(storeKitManagerReceivedProducts:)
                                                 name:CMProductRequestDidReceiveResponseNotification
                                               object:[CargoManager sharedManager]];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];


    [[CargoManager sharedManager] retryLoadingProducts];

    // Close button highlight
    UIImage *image = [UIImage imageNamed:@"close-pressed.png"];;
    [self.closeButton setBackgroundImage:image
                                forState:UIControlStateHighlighted];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Set popup to be center of parent view
    self.view.center = self.parentViewController.view.center;
    
    [CargoManager sharedManager].UIDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [CargoManager sharedManager].UIDelegate = nil;

    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidBecomeActive
{
    [[CargoManager sharedManager] retryLoadingProducts];
}


- (void)storeKitManagerReceivedProducts:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (IBAction)touchedCloseButton:(id)sender
{
    [self closeStore];
}

#pragma mark - IAP Callbacks

- (void)transactionDidFinishWithSuccess:(BOOL)success
{
    [_delegate storeDidFinishTransactionWithSuccess:success];
    if ( success )
    {
        [self closeStore];
    }
    
    self.tableView.userInteractionEnabled = YES;
    // Hide activity indicator
    [self.tableView reloadData];
}

- (void)closeStore
{
    [self close];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[GameData sharedData].storeKitElements count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // The header for the section is the region name -- get this from the region at the section index.
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We don't have nested subcategories
    int index = [indexPath indexAtPosition:1];

    // Get prototype cell.
    static NSString *StoreCellIdentifier = @"StoreCell";
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:StoreCellIdentifier];

    if (cell == nil) {
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:StoreCellIdentifier];
    }

    StoreKitElement *element = [GameData sharedData].storeKitElements[index];

    // Setting the store kit element automatically
    // setups the visual appearance of the cell
    cell.storeKitElement = element;

    return cell;
}

@end
