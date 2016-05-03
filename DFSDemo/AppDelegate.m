//
//  AppDelegate.m
//  DFSDemo
//
//  Created by sunyazhou on 16/5/3.
//  Copyright © 2016年 Baidu, Inc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)dfsAction:(NSButton *)sender
{
    NSOpenPanel *panelPath = [NSOpenPanel openPanel];
    [panelPath setCanChooseFiles:YES];
    [panelPath setCanChooseDirectories:YES];
    [panelPath setTitle:@"上传文件选择"];
    [panelPath setCanCreateDirectories:YES];
    [panelPath setPrompt:@"上传"];
    [panelPath setMessage:@"这就是message"];
    panelPath.allowsMultipleSelection = YES;
    [panelPath beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            [self dfsUrls:panelPath.URLs];
        }
    }];
}

- (void)dfsUrls:(NSArray *)urls
{
    NSLog(@"%@",urls);
    if (urls.count == 0) { return; }
    
    
    
    //深度遍历
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsRegularFileKey];
    
    for (NSURL *localUrl in urls) {
        NSDirectoryEnumerator *enumerator = [fileManager
                                             enumeratorAtURL:localUrl
                                             includingPropertiesForKeys:keys 
                                             options:0
                                             errorHandler:^(NSURL *url, NSError *error) {
                                                 // Handle the error.
                                                 // Return YES if the enumeration should continue after the error.
                                                 return YES;
                                             }];
        
        for (NSURL *url in enumerator) {
            NSError *error;
            NSNumber *isDirectory = nil;
            if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
                // handle error
            }
            else if (! [isDirectory boolValue]) {
                // No error and it’s not a directory; do something with the file
            }
            
            NSLog(@"%@", url);
        }
    }
    
    
    
}
@end
