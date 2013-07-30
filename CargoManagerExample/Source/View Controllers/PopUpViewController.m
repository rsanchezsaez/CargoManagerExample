//
//  PopUpViewController.m
//

#import "PopUpViewController.h"
#import "Shared.h"

#define UIColorPopupBackground ([UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.667])

@interface PopUpViewController ()

@end

@implementation PopUpViewController
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( !(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) )
    {
        return nil;
    }
    
    return self;
}

- (void)close
{
    [self.popUpDelegate popUpDidClose:self];

    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // iPhone 5 fix
    self.view.bounds = self.parentViewController.view.bounds;
    
    [self addBackground];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self removeBackground];

    [super viewDidDisappear:animated];
}

- (void)addBackground
{
    CGRect frame = self.parentViewController.view.frame;
    UIView *overlayBackground = [[UIView alloc] initWithFrame:frame];
    overlayBackground.backgroundColor = UIColorPopupBackground;

    [self.view insertSubview:overlayBackground atIndex:0];

    self.overlayBackground = overlayBackground;
}

- (void)removeBackground
{
    [self.overlayBackground removeFromSuperview];
}

@end
