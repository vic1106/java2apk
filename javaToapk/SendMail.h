//
//  SendMail.h
//  javaToapk
//
//  Created by cpuser on 6/3/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SendMail : NSViewController<NSApplicationDelegate,
NSComboBoxDelegate, NSComboBoxDataSource>{
    IBOutlet NSTextField *toField;
    IBOutlet NSTextField *fromField;
    IBOutlet NSTextField *subjectField;
    IBOutlet NSTextField *fileAttachmentField;
    IBOutlet NSTextView *messageContent;
    
    IBOutlet NSTextField *receiver_Name;
    IBOutlet NSTextField *sender_Name;
    IBOutlet NSComboBox* comboBox;
    NSArray* comboBoxItems;
    IBOutlet NSTextField *file_Name;
    NSArray* arr;
    NSArray* arr2;
    IBOutlet NSPathControl *locaFile;
    int i;
    int portNum;
    IBOutlet NSTextField *warning_To;
    IBOutlet NSTextField *warning_From;
    IBOutlet NSTextField *warning_Subject;
    IBOutlet NSTextField *warning_File;
    IBOutlet NSTextField *warning_Receiver;
    IBOutlet NSTextField *warning_Sender;
    IBOutlet NSTextField *warning_URL;
    IBOutlet NSTextField *warning_FileName;
    IBOutlet NSTextField *warning_Message;
    IBOutlet NSTextField *lb_DateAndTime;
    
    IBOutlet NSTextField *tf_password;
    IBOutlet NSTextField *tf_port;
    IBOutlet NSTextField *hostName;
}
- (IBAction)selectLocaFile:(id)sender;

- (IBAction)sendEmailMessage:(id)sender;
//- (IBAction)chooseFileAttachment:(id)sender;
- (IBAction)creatLetter:(id)sender;
- (IBAction)bt_createQR:(id)sender;

@end
