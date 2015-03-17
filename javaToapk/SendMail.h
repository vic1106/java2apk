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
}

- (IBAction)sendEmailMessage:(id)sender;
//- (IBAction)chooseFileAttachment:(id)sender;
- (IBAction)creatLetter:(id)sender;

@end
