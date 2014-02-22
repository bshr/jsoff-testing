//
//  LCPViewController.h
//  JavascriptOff for iPad
//
//  Created by Lukasz on 12/23/13.
//  Copyright (c) 2013 LionCubs Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCPViewController : UIViewController <UIWebViewDelegate, UISearchBarDelegate>
{
    IBOutlet UIView *mainView;
    __weak IBOutlet UISearchBar *addressBar;
    __weak IBOutlet UIButton *backButton;
    __weak IBOutlet UIButton *forwardButton;
    __weak IBOutlet UIButton *openButton;
    __weak IBOutlet UIWebView *webView;
    __weak IBOutlet UIProgressView *progressBar;
    NSURL *currentURL;
}
- (IBAction)openAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)forwardAction:(id)sender;
@end
