
#import "ViewController.h"
#import "FeedsListViewController.h"
#import "FeedsClient.h"
#import "M2x.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.tfMasterKey setText:@"59f68e0b7d47133bc17a46d9759b9072"];
    [self.tfURL setText:@"http://api-m2x.att.citrusbyte.com/v1"];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    M2x* m2x = [M2x shared];
    //set the Master Api Key
    m2x.api_key = [self.tfMasterKey text];
    //set the api url
    m2x.api_url = [self.tfURL text];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end