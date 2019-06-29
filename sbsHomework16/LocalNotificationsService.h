//
//  LocalNotificationsService.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 26/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;
#import "LocalNotificationsProtocol.h"


NS_ASSUME_NONNULL_BEGIN


@interface LocalNotificationsService : NSObject <LocalNotificationsInputProtocol>

@property (nonatomic, weak) id<LocalNotificationsOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
