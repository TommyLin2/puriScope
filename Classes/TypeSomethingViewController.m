//
//  TypeSomethingViewController.m
//  Pickers
//

#import "TypeSomethingViewController.h"

NSString *nname,*aadress,*pperson;

@implementation TypeSomethingViewController

@synthesize textField;
@synthesize delegate,personlabel;

- (IBAction)doneButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(typeSomethingViewController:didTypeSomething:)]) {
        [self.delegate typeSomethingViewController:self didTypeSomething:textField.text];
    }
	if([textField.text isEqualToString:@""])
	{
		nname=@"          -";
	}else
	{
        nname= textField.text;
	}
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- ( BOOL)textFieldShouldReturn:(UITextField *)textfField
{
	[textfField resignFirstResponder];
	return YES;
}

- (IBAction)showPeoplePicker:(id)sender
{
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactGivenNameKey,CNContactPostalAddressesKey];
    [self presentViewController:contactPicker animated:YES completion:nil];
}

-(void) contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    NSString *firstname = [contact givenName];
    if([firstname isEqualToString:@""])
        firstname=@"-";
    
    NSString *lastname = [contact familyName];
    if([lastname isEqualToString:@""])
        lastname=@"-";
    
    NSString *company =[contact organizationName];
    if([company isEqualToString:@""])
        company=@"-";
    
    NSString *name = [[NSString alloc] initWithFormat:@"%@,\n%@ %@ ",company,firstname, lastname];
    
    personlabel.text=[[NSString alloc]initWithFormat:@"%@",name];
    pperson = [[NSString alloc]initWithFormat:@"%@",name];
    aadress = @"-";

    if([contact.postalAddresses count]>0){
        CNLabeledValue *postalAddress = [contact.postalAddresses objectAtIndex:0];
        CNPostalAddress *postal = postalAddress.value;
        NSString *streetStr = [postal street];
        NSString *zipStr = [postal postalCode];
        NSString *cityStr = [postal city];
        aadress = [[NSString alloc] initWithFormat:@"%@,\n%@ %@", streetStr, zipStr, cityStr];
    }
    textField.text = aadress;
}

-(void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
}
@end
