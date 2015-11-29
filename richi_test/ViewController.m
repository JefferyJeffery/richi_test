//
//  ViewController.m
//  richi_test
//
//  Created by Jeffery on 2015/11/28.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import "ViewController.h"
#import "MovieTableViewCell.h"
#import "Movie.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()
@property (nonatomic,strong) ViewModel *viewModel;

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation ViewController
-(ViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[ViewModel alloc] init];
    }
    
    return _viewModel;
}

-(NSDictionary *)attributesPlaceholderWithSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    return @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize],
             NSForegroundColorAttributeName:textColor};
}

-(NSDictionary *)attributesPlaceholdertextColor
{
    return @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0],
             NSForegroundColorAttributeName:[UIColor colorWithRed:24.0/255.0 green:20.0/255.0 blue:27.0/255.0 alpha:1.0]};
}

#pragma mark - UITableViewDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.viewModel getMovies:^(NSError * _Nullable error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{ // 2
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 267.0;
}

#pragma mark - UITableViewDataSource<NSObject>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.datalist.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (MovieTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell" forIndexPath:indexPath];
    
    Movie *movie = [self.viewModel.datalist objectAtIndex:indexPath.row];
    
    [cell.posterImageView sd_setImageWithURL:[NSURL URLWithString:movie.poster] placeholderImage:[UIImage imageNamed:@"imagesNotFound"]];
    
    cell.yearLabel.attributedText =
    [[NSAttributedString alloc] initWithString:movie.year
                                    attributes:[self attributesPlaceholdertextColor]];
    
    cell.titleLabel.attributedText =
    [[NSAttributedString alloc] initWithString:movie.title
                                    attributes:[self attributesPlaceholdertextColor]];
    
    CGRect titleRect = [cell.titleLabel.attributedText boundingRectWithSize:CGSizeMake(CGRectGetWidth(cell.titleLabel.frame), FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    cell.titleHeight.constant = titleRect.size.height + 20.0;
    
    cell.ratingLabel.attributedText =
    [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"rating: %@", movie.rating]
                                    attributes:[self attributesPlaceholdertextColor]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
