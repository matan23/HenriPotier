//
//  BookListTableViewCell.m
//  HenriPotierShopper
//
//  Created by Mathieu Tan on 10/21/15.
//  Copyright © 2015 Mathieu Tan. All rights reserved.
//

#import "BookListTableViewCell.h"

#import "Book.h"

@interface BookListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *isbnLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation BookListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)feedCellWithBook:(Book *)book {
    self.titleLbl.text = book.title;
    self.isbnLbl.text = book.isbn;
    self.priceLbl.text = book.price;
}

//should be careful about cell reuse and deallocation when doing this async
- (void)asyncLoadCover {
    
}

@end
