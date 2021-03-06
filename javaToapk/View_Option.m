//
//  View_Option.m
//  javaToapk
//
//  Created by cpuser on 24/3/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import "View_Option.h"

@interface View_Option ()

@end

@implementation View_Option

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Setting";
    
    NSString* filePath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName2 = @"android_ant_path.txt";
    path = [filePath2 stringByAppendingPathComponent:fileName2];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:@"~/\n~/\nsftp.com\nkey\nkey\nkey\nkey\n~/" attributes:nil];
    }
    
    NSString *contents = [NSString stringWithContentsOfFile:path];
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    androidPath=[NSString stringWithFormat:@"%@",arr[0]];
    antPath=[NSString stringWithFormat:@"%@",arr[1]];
    serverPath=[NSString stringWithFormat:@"%@",arr[2]];
    keyPath=[NSString stringWithFormat:@"%@",arr[3]];
    keyName=[NSString stringWithFormat:@"%@",arr[4]];
    keypw1=[NSString stringWithFormat:@"%@",arr[5]];
    keypw2=[NSString stringWithFormat:@"%@",arr[6]];
    qrPath=[NSString stringWithFormat:@"%@",arr[7]];
    // Do view setup here.
    
    [path_android setStringValue:androidPath];
    [path_ant setStringValue:antPath];
    [path_server setStringValue:serverPath];
    [keyStore setStringValue:keyPath];
    [keyAlias setStringValue:keyName];
    [keyStore_pw setStringValue:keypw1];
    [keyAlias_pw setStringValue:keypw2];
    [path_QR setStringValue:qrPath];


}

//Set some control
- (IBAction)bt_save:(id)sender {
    
    androidPath=[path_android stringValue];
    antPath=[path_ant stringValue];
    serverPath=[path_server stringValue];
    keyPath=[keyStore stringValue];
    keyName=[keyAlias stringValue];
    keypw1=[keyStore_pw stringValue];
    keypw2=[keyAlias_pw stringValue];
    qrPath=[path_QR stringValue];
    
    if(![androidPath isEqualToString:@""]&&![antPath isEqualToString:@""]&&![serverPath isEqualToString:@""]){
        contents = @"";
        [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil ];
        
        for(i=0;i<8;i++){
            if(i==0){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",androidPath]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if (i==1){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",antPath]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if (i==2){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",serverPath]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if (i==3){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",keyPath]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if (i==4){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",keyName]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if (i==5){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",keypw1]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if (i==6){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",keypw2]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if (i==7){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@",qrPath]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            [lb_okay setStringValue:@"The paths are saved."];
        }
        
    }else{
        [lb_okay setStringValue:@"Please enter the paths."];
         }

}
@end
