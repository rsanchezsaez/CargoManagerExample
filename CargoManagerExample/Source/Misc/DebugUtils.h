//
//  DebugUtils.h
//
//  Created by Ricardo Sánchez-Sáez on 11/03/13.
//
//
// Adapted from: http://iphoneprogrammingfordummies.blogspot.ie/2010/09/nslog-tricks-log-only-in-debug-mode-add.html
//

#ifndef _DebugUtils_h
#define _DebugUtils_h

// Print only in Debug mode
#ifdef DEBUG
#define DBLog(fmt,...) NSLog(@"%@",[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);
#else
#define DBLog(...)
#endif

// DBLog but only print out if assert is true
#ifdef DEBUG
#define DBALog( assert , fmt , ... ) if( assert ) { DBLog( fmt,##__VA_ARGS__); }
#else
#define DBALog(...)
#endif


// Print function name and line number only in Debug
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


// DLog but only print out if assert is true
#ifdef DEBUG
#define DALog( assert , fmt , ... ) if( assert ) { DLog( fmt,##__VA_ARGS__); }
#else
#define DALog(...)
#endif


// Print function name and line number in Debug and release
#define ALog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);



#endif // define _DebugUtils_h

