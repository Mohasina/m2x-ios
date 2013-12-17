
#import "BatchListViewController.h"
#import "BatchDetailsViewController.h"

@interface BatchListViewController ()

@end

@implementation BatchListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    _dataSourceClient = [[DataSourceClient alloc] init];
    
    //get list of feeds without parameters
    [_dataSourceClient listBatchWithSuccess:^(id object) {
        //success callback
        [self didGetBatches:object];
        
    } failure:^(NSError *error, NSDictionary *message) {
        
        [self showError:error WithMessage:message];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - self

-(void)didGetBatches:(NSDictionary*)batches{
    
    NSDictionary *response = [batches objectForKey:@"batches"];
    
    _data = [NSMutableArray array];
    
    for (id batch in response) {
        [_data addObject:batch];
    }
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *feedData = [_data objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:[feedData valueForKey:@"name"]];
    [[cell detailTextLabel] setText:[feedData valueForKey:@"description"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    return;
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    BatchDetailsViewController *batchDetailsVC = segue.destinationViewController;
    
    UITableViewCell *batch_tableViewSelected = sender;
    
    NSIndexPath *batchIndexPath = [[self tableView] indexPathForCell:batch_tableViewSelected];
    
    NSDictionary *batchDict = [_data objectAtIndex:[batchIndexPath row]];
    
    batchDetailsVC.batch_id = [batchDict valueForKey:@"id"];
    
    batchDetailsVC.dataSourceClient = _dataSourceClient;
    
    batchDetailsVC.title = [batchDict valueForKey:@"name"];
    
}

#pragma mark - helper

-(void)showError:(NSError*)error WithMessage:(NSDictionary*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", message]
                                                   delegate:nil cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
