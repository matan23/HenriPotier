//
//  BookListTableViewCell.h
//  HenriPotierShopper
//
//  Created by Mathieu Tan on 10/21/15.
//  Copyright © 2015 Mathieu Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Book;

@interface BookListTableViewCell : UITableViewCell

- (void)feedCellWithBook:(Book *)book;

@end
