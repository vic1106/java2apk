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
#import <MailCore/MailCore.h>
#import <ZXingObjC/ZXingObjC.h>

@interface SendMail (delegate) <SBApplicationDelegate>

@end

@implementation SendMail

- (void)viewDidLoad {
    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    qrPath= [NSString stringWithFormat:@"%@",arr_option[7]];
    [super viewDidLoad];
    self.title=@"Send Email";
    [tf_port setIntValue:465];
    portNum=[tf_port intValue];
    [warning_To setStringValue:@""];
    [warning_From setStringValue:@""];
    [warning_Subject setStringValue:@""];
    [warning_File setStringValue:@""];
    [warning_Receiver setStringValue:@""];
    [warning_Sender setStringValue:@""];
    [warning_URL setStringValue:@""];
    [warning_FileName setStringValue:@""];
    [warning_Message setStringValue:@""];
    // Do view setup here.
//    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* fileName = @"uploadRecord_j2a.txt";
//    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"uploadRecord_j2a" ofType:@"txt"];
    
    NSString *contents= [NSString stringWithContentsOfFile:path];
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
//    NSOpenPanel *op = [NSOpenPanel openPanel];
//    
//    /* allow directories */
//    [op setCanChooseDirectories:YES];
//    
//    /* single file selections */
//    [op setAllowsMultipleSelection:NO];
//    [op setCanChooseFiles: YES];
//    
//    //    [op setAllowedFileTypes:[NSArray arrayWithObjects: @"gif", @"jpg", @"pdf", @"png", @"rtf", @"txt", @"zip",@"apk", nil]];
//    
//    /* run the open panel */
//    NSInteger openResult = [op runModal];
//    
//    /* save the selection, if a file/directory was chosen */
//    if ( NSOKButton == openResult ) {
//        [fileAttachmentField setStringValue: [[op URLs] objectAtIndex:0]];
//    }
}




- (IBAction)selectLocaFile:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",locaFile.URL.path];
    [fileAttachmentField setStringValue:projectLocation];
}

- (IBAction)sendEmailMessage:(id)sender {
    NSString*warningTo=[toField stringValue];
    NSString*warningFrom=[fromField stringValue];
    NSString*warningSubject=[fromField stringValue];
    NSString*warningMessage=[messageContent string];
    
    portNum=[tf_port intValue];

    NSString* senderName = [sender_Name stringValue];
    NSString* senderpassword = [tf_password stringValue];
    NSString* fromMailBox = [fromField stringValue];
    NSString* toMailBox = [toField stringValue];
    NSString* receiverName = [receiver_Name stringValue];
    NSString* subject = [subjectField stringValue];
    NSString* fileAttachment = [fileAttachmentField stringValue];
    NSString* message = [messageContent string];
//    NSString* host1 = [hostName stringValue];
    NSString* host2 = @"smtp.gmail.com";
    NSString* fromAddress = [NSString stringWithFormat:@"%@",fromMailBox];
    
    if([warningTo isEqualToString:@""]){
        [warning_To setStringValue:@"!!"];
    }else{
        [warning_To setStringValue:@""];
    }
    if([warningFrom isEqualToString:@""]){
        [warning_From setStringValue:@"!!"];
    }else{
        [warning_From setStringValue:@""];
    }

    if([warningSubject isEqualToString:@""]){
        [warning_Subject setStringValue:@"!!"];
    }else{
        [warning_Subject setStringValue:@""];
    }

    if([warningMessage isEqualToString:@""]){
        [warning_Message setStringValue:@"!!"];
    }else{
        [warning_Message setStringValue:@""];
    }

    if(![warningTo isEqualToString:@""]&&![warningFrom isEqualToString:@""]&&![warningSubject isEqualToString:@""]&&![warningMessage isEqualToString:@""]){
        
        MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
        smtpSession.hostname = host2;
        smtpSession.port = portNum;
        smtpSession.username = fromAddress;
        smtpSession.password = senderpassword;
        smtpSession.authType = MCOAuthTypeSASLPlain;
        smtpSession.connectionType = MCOConnectionTypeTLS;
        
//        MCOIMAPSession *session = [[MCOIMAPSession alloc] init];
//        [session setHostname:@"imap.gmail.com"];
//        [session setPort:993];
//        [session setUsername:@"siumankung@gmail.com"];
//        [session setPassword:@"Rj@600860"];
//        [session setConnectionType:MCOConnectionTypeTLS];
        
        MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
        MCOAddress *from = [MCOAddress addressWithDisplayName:senderName
                                                      mailbox:fromMailBox];
        MCOAddress *to = [MCOAddress addressWithDisplayName:receiverName
                                                    mailbox:toMailBox];
        [[builder header] setFrom:from];
        [[builder header] setTo:@[to]];
        [[builder header] setSubject:subject];
        NSString *attachmentPath=fileAttachment;
        MCOAttachment *attachment = [MCOAttachment attachmentWithContentsOfFile:attachmentPath];
        [builder addAttachment:attachment];
        [builder setHTMLBody: message];
        NSData * rfc822Data = [builder data];
        
        MCOSMTPSendOperation *sendOperation =
        [smtpSession sendOperationWithData:rfc822Data];
        [sendOperation start:^(NSError *error) {
            if(error) {
                NSLog(@"Error sending email: %@", error);
            } else {
                NSLog(@"Successfully sent email!");
            }
        }];
    }
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
        i =(int) index;
        return [comboBoxItems objectAtIndex:index];
    }
    return nil;
}
- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
    if(i>0){
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"dateAndtime" ofType:@"txt"];
        NSString *contents2= [NSString stringWithContentsOfFile:path2];
        arr2 = [contents2 componentsSeparatedByCharactersInSet:
                [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
        NSString*time=[NSString stringWithFormat:@"%@",arr2[i]];
        [lb_DateAndTime setStringValue:[NSString stringWithFormat:@"Date and Time : %@",time]];
    }else{
        [lb_DateAndTime setStringValue:@""];
    }
    
    
    NSLog(@"[%@ %@] value == %@", NSStringFromClass([self class]),
          NSStringFromSelector(_cmd), [comboBoxItems objectAtIndex:
                                       [(NSComboBox *)[notification object] indexOfSelectedItem]]);
    NSString* select=[NSString stringWithFormat:@"%@",[comboBoxItems objectAtIndex:
    [(NSComboBox *)[notification object] indexOfSelectedItem]]];
    arr = [select componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"/"]];
    int y=(int)arr.count-1;
    NSString*pathElement=arr[y];
    NSString*pathElement2=[NSString stringWithFormat:@"%@",pathElement];
    [file_Name setStringValue:pathElement2];
    
}


- (IBAction)creatLetter:(id)sender {
    NSString*warningReceiver=[receiver_Name stringValue];
    NSString*warningSender=[sender_Name stringValue];
    NSString*warningURL=[comboBox stringValue];
    
    
    if([warningReceiver isEqualToString:@""]){
        [warning_Receiver setStringValue:@"!!"];
    }else{
        [warning_Receiver setStringValue:@""];
    }
    if([warningSender isEqualToString:@""]){
        [warning_Sender setStringValue:@"!!"];
    }else{
        [warning_Sender setStringValue:@""];
    }
    
    if([warningURL isEqualToString:@""]||[warningURL isEqualToString:@"Upload Record:"]){
        [warning_URL setStringValue:@"!!"];
    }else{
        [warning_URL setStringValue:@""];
    }
    
    
    
    if(![warningReceiver isEqualToString:@""]&&![warningSender isEqualToString:@""]&&![warningURL isEqualToString:@""]){
        
    NSString*cbBox=@"";
    if([[comboBox stringValue]isEqualToString:@"Upload Record:"]){
        cbBox=@"";
    }else{
        cbBox=[comboBox stringValue];
        NSError *error = nil;
        ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
        ZXBitMatrix* result = [writer encode:cbBox
                                      format:kBarcodeFormatQRCode
                                       width:500
                                      height:500
                                       error:&error];
        if (result) {
            CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
            NSString* fileName = [file_Name stringValue];
            NSString* filePath = [NSString stringWithFormat:@"%@/%@.png",qrPath,fileName];
            [fileAttachmentField setStringValue:filePath];
                                  
                //        NSImage* a = [self imageFromCGImageRef:image];
                //        [qrImage setImage:a];
                                  
                NSURL *fileURL = [NSURL fileURLWithPath:filePath];
                CGImageDestinationRef dr = CGImageDestinationCreateWithURL((__bridge CFURLRef)fileURL, kUTTypePNG , 1, NULL);
                                  
                CGImageDestinationAddImage(dr, image, NULL);
                CGImageDestinationFinalize(dr);
                                  
                CFRelease(dr);
                // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
                } else {
                    NSString *errorMessage = [error localizedDescription];
                }
    }
    
    NSString* letterContent=[NSString stringWithFormat:@"This is %@ file.",[file_Name stringValue]];
    [messageContent setString:letterContent];
    }
    
}

- (IBAction)bt_createQR:(id)sender {
    
    
}

@end
