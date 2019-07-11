//
//  SBSFlickrPhotoCell.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;


NS_ASSUME_NONNULL_BEGIN


/**
 Ячейка Collection View для отображения изображений на главном экране приолжения.
 */
@interface SBSFlickrPhotoCell : UICollectionViewCell

/**
 Устанавливает изображение в главный UIImageView ячейки.

 @param image Изображение которое будет отображаться в ячейке.
 */
- (void)configureCellWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
