//
//  ViewController.m
//  SuperHeroPedia
//
//  Created by Nicolas Semenas on 04/08/14.
//  Copyright (c) 2014 Nicolas Semenas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *heroes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    NSDictionary *superperson = @{@"name":@"superman",
//                               @"age":@"24"
//                               };
//    NSDictionary *spiderperson = @{@"name":@"spiderperson",
//                               @"age":@"18"
//                               };
//    
//    self.heroes = [NSArray arrayWithObjects:superperson, spiderperson, nil];
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.heroes = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self.tableView reloadData];
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"%@", jsonString);

        
    }];

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
    NSDictionary * superhero = [self.heroes objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID"];
    cell.textLabel.text = [superhero objectForKey:@"name"];
    
    cell.detailTextLabel.text = [superhero objectForKey:@"description"];
    
    NSURL *url = [NSURL URLWithString:[superhero objectForKey:@"avatar_url"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData:data];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.heroes.count;
}


@end
