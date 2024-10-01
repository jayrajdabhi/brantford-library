<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Jayrajsinh_BookStore.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
    <header class="jumbotron"></header>
    <main>
       <div class="row">
        <div class="col-sm-6">
            <div class="form-group">
                <div class="col-sm-12"><asp:ListBox ID="lstCart" runat="server" CssClass="form-control"></asp:ListBox></div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group">
                <br />
                <div class="col-sm-12"><asp:Button ID="btnRemove" runat="server" 
                    Text="Remove Item" onclick="btnRemove_Click" CssClass="btn btn-danger" /></div>
                <br />
                <div class="col-sm-12"><asp:Button ID="btnEmpty" runat="server" 
                    Text="Empty Cart" onclick="btnEmpty_Click" CssClass="btn btn-info" /></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="form-group">
                <asp:Label ID="lblMessage" runat="server" EnableViewState="False"
                    CssClass="text-info col-sm-12"></asp:Label>
            </div>
            <div class="form-group">
                <div class="col-sm-12">
                    <br />
                    <asp:Button ID="btnContinue" runat="server"
                        PostBackUrl="~/Products.aspx" Text="Continue Shopping" CssClass="btn btn-success" />
                    <asp:Button ID="btnCheckOut" runat="server" Text="Check Out"  
                        onclick="btnCheckOut_Click" CssClass="btn btn-dark" />
                    
                </div>
            </div>
        </div>
    </div>
        <asp:Label ForeColor="Red" ID="cartEmpty" runat="server" Text="cart" Visible="false"></asp:Label>
        </main>
        </div>
</asp:Content>
