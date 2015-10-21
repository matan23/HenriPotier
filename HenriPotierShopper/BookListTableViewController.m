//
//  BookListTableViewController.m
//  HenriPotierShopper
//
//  Created by Mathieu Tan on 10/21/15.
//  Copyright © 2015 Mathieu Tan. All rights reserved.
//

#import "BookListTableViewController.h"

#import "MTJSocketStore.h"

#import "MTJSyncedTableViewDataSource.h"
#import "Book.h"
#import "BookListTableViewCell.h"

@interface BookListTableViewController () <MTJSyncedTableViewDataSourceDelegate, UITextFieldDelegate> {
    MTJSyncedTableViewDataSource *_dataSource;
}

@end

NSString * const BookCellIdentifier = @"BookListCell";

@implementation BookListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setupDataSource];
    [self loadBooks];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)setupDataSource {
    _dataSource = [[MTJSocketStore sharedStore] tableViewDataSourceForType:[Book class]];
    [_dataSource setDelegate:self tableView:self.tableView withCellIdentifier:BookCellIdentifier];
    
    [_dataSource sync];
}

- (void)loadBooks {
    [[MTJSocketStore sharedStore] syncCollectionOfType:(id<MTJSyncedEntity>)[Book class] completion:^(NSArray *collection, NSError *error) {
       
        if (error) NSLog(@"error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MTJSyncedTableViewDataSourceDelegate

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object {
    [(BookListTableViewCell *)cell feedCellWithBook:object];
}

- (void)dataInserted {
    //    nothing for now
}

- (void)deleteObject:(id)object {
    //    nothing for now
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
