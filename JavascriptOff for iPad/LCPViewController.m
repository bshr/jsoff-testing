//
//  LCPViewController.m
//  JavascriptOff for iPad
//
//  Created by Lukasz on 12/23/13.
//  Copyright (c) 2013 LionCubs Project. All rights reserved.
//

#import "LCPViewController.h"

@interface LCPViewController ()

@end

@implementation LCPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    webView.delegate = self;
    addressBar.delegate = self;
    currentURL = [NSURL URLWithString:@"about:blank"];
    [webView loadHTMLString:@"" baseURL:currentURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)delegateWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    currentURL = webView.request.mainDocumentURL;
    addressBar.text = currentURL.absoluteString;
    if([request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"data"]) {
        //todo: special http URLs, e.g. maps.apple.com
        return YES;
    }
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)delegateWebView
{
    currentURL = webView.request.mainDocumentURL;
    addressBar.text = currentURL.absoluteString;
    progressBar.progress = 0.9;
}

- (void)webView:(UIWebView *)delegateWebView didFailLoadWithError:(NSError *)error
{
    currentURL = webView.request.mainDocumentURL;
    addressBar.text = currentURL.absoluteString;
    progressBar.progress = 0;
}

- (void)webViewDidFinishLoad:(UIWebView *)delegateWebView
{
    currentURL = webView.request.mainDocumentURL;
    addressBar.text = currentURL.absoluteString;
    /*
    [delegateWebView stringByEvaluatingJavaScriptFromString:@"null==function(){var a = document.getElementsByTagName('a');for(i=0;i<a.length;i++){a.item(i).target='_self'}}()"]; //fix target attributes in sandbox hrefs, no longer needed
    [delegateWebView stringByEvaluatingJavaScriptFromString:@"null==function(){var a = document.getElementsByTagName('form');for(i=0;i<a.length;i++){a.item(i).target='_self'}}()"]; //fix target attributes in sandbox forms, no longer needed
     */
    progressBar.progress = 0;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self openAction:searchBar];
}

- (IBAction)openAction:(id)sender {
    if([addressBar.text length]<7 || (![[addressBar.text substringToIndex:7] isEqualToString:@"http://"] && ![[addressBar.text substringToIndex:8] isEqualToString:@"https://"])) {
        addressBar.text = [NSString stringWithFormat:@"http://%@", addressBar.text];
    }
    currentURL = [NSURL URLWithString:[addressBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [webView loadRequest:[NSURLRequest requestWithURL:currentURL]];
}

- (IBAction)backAction:(id)sender {
    [webView goBack];
}

- (IBAction)forwardAction:(id)sender {
    [webView goForward];
}

@end
