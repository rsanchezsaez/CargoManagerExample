//
//  HighlightButton.m
//

#import "HighlightButton.h"

#import "Shared.h"

#define UIColorWhiteHighlightButtonOverlay ([UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.20])
#define UIColorWhiteHighlightButtonDisabledOverlay ([UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5])

#define UIColorHighlightButtonOverlay ([UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.15])
#define UIColorHighlightButtonDisabledOverlay ([UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5])

@interface HighlightButton()

@property (nonatomic) UIView *highlightedOverlay;
@property (nonatomic) UIView *disabledOverlay;

@end

@implementation HighlightButton

- (void)awakeFromNib
{
    self.highlightedOverlay = [[UIView alloc] init];
    self.highlightedOverlay.backgroundColor = UIColorHighlightButtonOverlay;

    self.disabledOverlay = [[UIView alloc] init];
    self.disabledOverlay.backgroundColor = UIColorHighlightButtonDisabledOverlay;

    self.forceHighlight = NO;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted || self.forceHighlight)
    {
        self.highlightedOverlay.bounds = self.bounds;
        self.highlightedOverlay.center = [self convertPoint:self.center fromView:self.superview];
        [self addSubview:self.highlightedOverlay];
    }
    else
    {
        [self.highlightedOverlay removeFromSuperview];
    }
    [super setHighlighted:( highlighted || self.forceHighlight )];
}

- (void)setEnabled:(BOOL)enabled
{
    if (!enabled)
    {
        self.disabledOverlay.bounds = self.bounds;
        self.disabledOverlay.center = [self convertPoint:self.center fromView:self.superview];

        [self addSubview:self.disabledOverlay];
    }
    else
    {
        [self.disabledOverlay removeFromSuperview];
    }
    [super setEnabled:enabled];
}

@end


@implementation WhiteHighlightButton

- (void)awakeFromNib
{
    self.highlightedOverlay = [[UIView alloc] init];
    self.highlightedOverlay.backgroundColor = UIColorWhiteHighlightButtonOverlay;

    self.disabledOverlay = [[UIView alloc] init];
    self.disabledOverlay.backgroundColor = UIColorWhiteHighlightButtonDisabledOverlay;

    self.forceHighlight = NO;
}

@end
