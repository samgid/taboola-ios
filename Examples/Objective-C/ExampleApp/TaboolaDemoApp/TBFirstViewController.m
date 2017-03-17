//
//  TBFirstViewController.m
//  TaboolaDemoApp


#import "TBFirstViewController.h"

#define BOTTOM_MARGIN 20
#define HEADER_LENGTH 37

@implementation TBFirstViewController

#pragma mark - Life cycle
- (void)viewDidLoad{
    [super viewDidLoad];

	//load tabolaView
	mTaboolaView.delegate = self;
    mTaboolaView.ownerViewController = self;
    mTaboolaView.mode = @"thumbnails-sdk1";
	mTaboolaView.publisher = @"betterbytheminute-app";
    mTaboolaView.pageType = @"article";
    mTaboolaView.pageUrl = @"http://www.example.com";
    mTaboolaView.placement = @"Mobile";
	mTaboolaView.autoResizeHeight = YES;
    mTaboolaView.scrollEnable = NO;
    mTaboolaView.enableClickHandler = YES;

	NSDictionary *lPageDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.example.com/ref", @"referrer", nil];
    [mTaboolaView setOptionalPageCommands:lPageDictionary];

    NSDictionary *lModeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"mix", @"target_type", nil];
    [mTaboolaView setOptionalModeCommands:lModeDictionary];
	
    [mTaboolaView fetchContent];
}

#pragma mark - Rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[mScrollView setContentSize:CGSizeMake(mScrollView.frame.size.width, CGRectGetMaxY(mTextLabel.frame))];
}

#pragma mark - TaboolaView delegate
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic{
	NSLog(@"Start load request on first screen: %@ isOrganic? %@", pURLString, isOrganic ? @"YES":@"NO");
    if (isOrganic) {
        NSLog(@"organic items should open as native app pages.");
    }
	return YES;
}

- (void)taboolaDidReceiveAd:(UIView *)view{
    NSLog(@"Delegate: didReceiveAd event");
}

- (void)taboolaDidFailAd:(NSError *)error  {
    NSLog(@"Delegate: didFailAd event");
}

#pragma mark - UI
- (BOOL)prefersStatusBarHidden{
	return YES;
}

#pragma mark - Buttons methods
- (IBAction)refreshButtonPressed:(id)sender{
	[mTaboolaView refresh];
}

- (IBAction)resetButtonPressed:(id)sender{
	[mTaboolaView reset];
}

- (IBAction)loadAgainButtonPressed:(id)sender{
    mTaboolaView.scrollEnable = YES;
    mTaboolaView.pageType = @"article";
    mTaboolaView.pageUrl = @"http://www.example.com";
    mTaboolaView.placement = @"mobile";
    NSDictionary *lCommandsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.example.com/ref", @"referrer", nil];
    [mTaboolaView setOptionalPageCommands:lCommandsDictionary];
    [mTaboolaView fetchContent];
}

@end
