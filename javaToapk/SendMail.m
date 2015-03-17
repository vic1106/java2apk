//
//  SendMail.m
//  javaToapk
//
//  Created by cpuser on 6/3/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//
#import <CoreServices/CoreServices.h>
#import "SendMail.h"
#import "Mail.h"

@interface SendMail (delegate) <SBApplicationDelegate>

@end

@implementation SendMail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Send Email";
    // Do view setup here.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"uploadRecord_j2a.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSString *contents= [NSString stringWithContentsOfFile:fileAtPath];
    comboBoxItems = [contents componentsSeparatedByCharactersInSet:
                     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
}

- (void)awakeFromNib {
    
    [messageContent setFont:[NSFont fontWithName:@"Courier" size:12]];
    
}


- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}


/* Part of the SBApplicationDelegate protocol.  Called when an error occurs in
 Scripting Bridge method. */
- (id)eventDidFail:(const AppleEvent *)event withError:(NSError *)error
{
    [[NSAlert alertWithMessageText:@"Error" defaultButton:@"OK" alternateButton:nil otherButton:nil
         informativeTextWithFormat: @"%@", [error localizedDescription]] runModal];
    return nil;
}


- (IBAction)chooseFileAttachment:(id)sender {
    NSOpenPanel *op = [NSOpenPanel openPanel];
    
    /* allow directories */
    [op setCanChooseDirectories:YES];
    
    /* single file selections */
    [op setAllowsMultipleSelection:NO];
    [op setCanChooseFiles: YES];
    
    //    [op setAllowedFileTypes:[NSArray arrayWithObjects: @"gif", @"jpg", @"pdf", @"png", @"rtf", @"txt", @"zip",@"apk", nil]];
    
    /* run the open panel */
    NSInteger openResult = [op runModal];
    
    /* save the selection, if a file/directory was chosen */
    if ( NSOKButton == openResult ) {
        [fileAttachmentField setStringValue: [[op URLs] objectAtIndex:0]];
    }
}




- (IBAction)sendEmailMessage:(id)sender {
    
    /* create a Scripting Bridge object for talking to the Mail application */
    MailApplication *mail = [SBApplication applicationWithBundleIdentifier:@"com.apple.Mail"];
    
    /* set ourself as the delegate to receive any errors */
    mail.delegate = self;
    
    /* create a new outgoing message object */
    MailOutgoingMessage *emailMessage = [[[mail classForScriptingClass:@"outgoing message"] alloc] initWithProperties:
                                         [NSDictionary dictionaryWithObjectsAndKeys:
                                          [subjectField stringValue], @"subject",
                                          [[messageContent textStorage] string], @"content",
                                          nil]];
				
    /* add the object to the mail app  */
    [[mail outgoingMessages] addObject: emailMessage];
    
    /* set the sender, show the message */
    emailMessage.sender = [fromField stringValue];
    emailMessage.visible = YES;
    
    /* Test for errors */
    if ( [mail lastError] != nil )
        return;
				
    /* create a new recipient and add it to the recipients list */
    MailToRecipient *theRecipient = [[[mail classForScriptingClass:@"to recipient"] alloc] initWithProperties:
                                     [NSDictionary dictionaryWithObjectsAndKeys:
                                      [toField stringValue], @"address",
                                      nil]];
    [emailMessage.toRecipients addObject: theRecipient];
//    [theRecipient release];
    
    /* Test for errors */
    if ( [mail lastError] != nil )
        return;
    
    /* add an attachment, if one was specified */
    NSString *attachmentFilePath = [fileAttachmentField stringValue];
    if ( [attachmentFilePath length] > 0 ) {
        MailAttachment *theAttachment;
        
        /* In Snow Leopard, the fileName property requires an NSString representing the path to the
         * attachment.  In Lion, the property has been changed to require an NSURL.   */
        SInt32 osxMinorVersion;
        Gestalt(gestaltSystemVersionMinor, &osxMinorVersion);
        
        /* create an attachment object */
        if ( osxMinorVersion >= 7 )
            theAttachment = [[[mail classForScriptingClass:@"attachment"] alloc] initWithProperties:
                             [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSURL URLWithString:attachmentFilePath], @"fileName",
                              nil]];
        else
        /* The string we read from the text field is a URL so we must create an NSURL instance with it
         * and retrieve the old style file path from the NSURL instance. */
            theAttachment = [[[mail classForScriptingClass:@"attachment"] alloc] initWithProperties:
                             [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSURL URLWithString:attachmentFilePath] path], @"fileName",
                              nil]];
        
        /* add it to the list of attachments */
        [[emailMessage.content attachments] addObject: theAttachment];
        
//        [theAttachment release];
        
        /* Test for errors */
        if ( [mail lastError] != nil )
            return;
    }
    /* send the message */
    [emailMessage send];
    
//    [emailMessage release];
}

- (void)dealloc {
    //    [comboBoxItems release];
    //    [super dealloc];
}
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    
    return [comboBoxItems count];
}
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    if (aComboBox == comboBox) {
        return [comboBoxItems objectAtIndex:index];
    }
    return nil;
}
- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
    NSLog(@"[%@ %@] value == %@", NSStringFromClass([self class]),
          NSStringFromSelector(_cmd), [comboBoxItems objectAtIndex:
                                       [(NSComboBox *)[notification object] indexOfSelectedItem]]);
    
}


- (IBAction)creatLetter:(id)sender {
    NSString* letterContent=[NSString stringWithFormat:@"Dear %@,\n\n\n\n\nThis is %@ file.\n\n\nhttp://chart.apis.google.com/chart?chs=200x200&cht=qr&chld=|1&chl=%@\n\n\n\n\nRegard\n%@",
                             [receiver_Name stringValue],
                             [file_Name stringValue],
                             [comboBox stringValue],
                             [sender_Name stringValue]
                             ];
    [messageContent setString:letterContent];
    
}
@end
