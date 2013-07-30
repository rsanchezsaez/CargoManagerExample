//
//  Shared.m
//

#import "Shared.h"


NSString *formatInt(int number)
{
    return [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInt:number] numberStyle:NSNumberFormatterDecimalStyle];
}