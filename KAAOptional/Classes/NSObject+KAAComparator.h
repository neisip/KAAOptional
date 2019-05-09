//
//  NSObject+KAAComparator.h
//  KAAOptional
//
//  Created by Alex on 15/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KAAComparator)
- (BOOL)kaa_isEqualTo:(nonnull id)value;
@end

NS_ASSUME_NONNULL_END
