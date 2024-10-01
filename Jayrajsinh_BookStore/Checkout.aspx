<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Jayrajsinh_BookStore.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="text-danger" HeaderText="Please correct the following errors:" DisplayMode="BulletList" />
          
         
        <h2>Contact Information</h2>
        <div class="form-group">
            <label for="email">Email</label>
            <asp:TextBox ID="email" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="email" ErrorMessage="Email is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="email" ErrorMessage="Invalid email format" CssClass="text-danger" Display="Dynamic" ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"></asp:RegularExpressionValidator>
        </div>
        <div class="form-group">
            <label for="reemail">Re-enter Email</label>
            <asp:TextBox ID="reemail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvReEmail" runat="server" ControlToValidate="reemail" ErrorMessage="Re-entering email is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvEmail" runat="server" ControlToCompare="email" ControlToValidate="reemail" ErrorMessage="Emails do not match" CssClass="text-danger" Display="Dynamic"></asp:CompareValidator>
            <asp:RegularExpressionValidator ID="revReEmail" runat="server" ControlToValidate="reemail" ErrorMessage="Invalid email format" CssClass="text-danger" Display="Dynamic" ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"></asp:RegularExpressionValidator>
        </div>

        <br/>
        <div class="form-group">
            <label for="firstname">First name</label>
            <asp:textbox id="firstname" runat="server" cssclass="form-control"  ></asp:textbox>
            <asp:requiredfieldvalidator id="rfvfirstname" runat="server" controltovalidate="firstname" errormessage="first name is required" cssclass="text-danger" display="dynamic"></asp:requiredfieldvalidator>
        </div>
        <div class="form-group">
            <label for="lastname">Last name</label>
            <asp:textbox id="lastname" runat="server" cssclass="form-control"  ></asp:textbox>
            <asp:requiredfieldvalidator id="rfvlastname" runat="server" controltovalidate="lastname" errormessage="last name is required" cssclass="text-danger" display="dynamic"></asp:requiredfieldvalidator>
        </div>
        <div class="form-group">
            <label for="phone">Phone no</label>
            <asp:TextBox ID="phone" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvphone" runat="server" ControlToValidate="phone" ErrorMessage="Phone number is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revphone" runat="server" ControlToValidate="phone" ErrorMessage="Invalid format. Please use 123-456-7890" CssClass="text-danger" Display="Dynamic" ValidationExpression="^\d{3}-\d{3}-\d{4}$"></asp:RegularExpressionValidator>
        </div>


        <h2>Billing address</h2>
        <div class="form-group">
            <label for="address">Address</label>
            <asp:textbox id="address" runat="server" cssclass="form-control"  ></asp:textbox>
            <asp:requiredfieldvalidator id="rfvaddress" runat="server" controltovalidate="address" errormessage="address is required" cssclass="text-danger" display="dynamic"></asp:requiredfieldvalidator>
        </div>
        <div class="form-group">
            <label for="city">City</label>
            <asp:textbox id="city" runat="server" cssclass="form-control"  ></asp:textbox>
            <asp:requiredfieldvalidator id="rfvcity" runat="server" controltovalidate="city" errormessage="city is required" cssclass="text-danger" display="dynamic"></asp:requiredfieldvalidator>
        </div>
        <div class="form-group">
            <label for="state">State</label>
            <asp:textbox id="state" runat="server" cssclass="form-control"  ></asp:textbox>
            <asp:requiredfieldvalidator id="rfvstate" runat="server" controltovalidate="state" errormessage="state is required" cssclass="text-danger" display="dynamic"></asp:requiredfieldvalidator>
        </div>
        <div class="form-group">
            <label for="zipcode">Zip code</label>
            <asp:TextBox ID="zipcode" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvzipcode" runat="server" ControlToValidate="zipcode" ErrorMessage="Zip code is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revzipcode" runat="server" ControlToValidate="zipcode" ErrorMessage="Invalid zip code format. Please use A1A 1A1 or A1A1A1" CssClass="text-danger" Display="Dynamic" ValidationExpression="^[A-Za-z]\d[A-Za-z][ ]?\d[A-Za-z]\d$"></asp:RegularExpressionValidator>
        </div>


        <h2>Optional data</h2>
        <h3>please let me know about:</h3>
        <div class="form-group form-check">
            <asp:checkbox id="cbnewproducts" runat="server" />
            <label for="cbnewproducts" class="form-check-label">new products</label>
        </div>
        <div class="form-group form-check">
            <asp:checkbox id="cbneweditions" runat="server"/>
            <label for="cbneweditions" class="form-check-label">new editions</label>
        </div>
        <div class="form-group form-check">
            <asp:checkbox id="cbspecialoffers" runat="server" />
            <label for="cbspecialoffers" class="form-check-label">special offers</label>
        </div>
        <div class="form-group form-check">
            <asp:checkbox id="cblocalevents" runat="server"/>
            <label for="cblocalevents" class="form-check-label">local events</label>
        </div>

        <h3>please contact me via:</h3>
        <div class="form-group form-check">
            <asp:radiobutton id="rbtwitter" runat="server" groupname="contactus" />
            <label for="rbtwitter" class="form-check-label">twitter</label>
        </div>
        <div class="form-group form-check">
            <asp:radiobutton id="rbfacebook" runat="server" groupname="contactus"/>
            <label for="rbfacebook" class="form-check-label">facebook</label>
        </div>
        <div class="form-group form-check">
            <asp:radiobutton id="rbtextmessage" runat="server" groupname="contactus" />
            <label for="rbtextmessage" class="form-check-label">text message</label>
        </div>
        <div class="form-group form-check">
            <asp:radiobutton id="rbemail" runat="server" groupname="contactus"/>
            <label for="rbemail" class="form-check-label">email</label>
        </div>
    <br />
        <asp:Button ID="Checkout" runat="server" Text="Checkout" cssClass="btn btn-success" onClick="Checkout_Click"/>
        <asp:Button ID="CancleOrder" runat="server" Text="Cancle Order" cssClass="btn btn-danger" onClick="CancleOrder_Click" CausesValidation="false"/>
         
        
</asp:Content>
