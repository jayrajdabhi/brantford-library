<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="Jayrajsinh_BookStore.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [book_id], [book_title], [author], [description], [price], [image_url] FROM [book] ORDER BY [book_title]"></asp:SqlDataSource>
        <header class="jumbotron"></header>
        <main>
            
                <h2>
                    <asp:Literal ID="litWelcomeMessage" runat="server"></asp:Literal>
                </h2>
            
            <div class="row">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label class="col-sm-5">Please select a product:</label>
                            <div class="col-sm-6">
                                <asp:DropDownList ID="ddlBooks" runat="server" AutoPostBack="True" 
                                    DataSourceID="SqlDataSource1" DataTextField="book_title" 
                                    DataValueField="book_id" CssClass="form-control">
                                </asp:DropDownList>
                                
                            </div>
                        </div>   
                        <div class="form-group">
                            <br />
                            <div class="col-sm-12"><h4>Book Name : <asp:Label ID="book_title" runat="server"></asp:Label></h4></div>
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-12">
                                <h5>
                                Description :</h5> <asp:Label ID="description" runat="server"></asp:Label></div>
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-12">
                                <h5>
                                Author :</h5> <asp:Label ID="author" runat="server"></asp:Label>
                            </div>
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-sm-12"><h5>Price : </h5>$ <asp:Label ID="lblUnitPrice" runat="server"></asp:Label></div>
                        </div>
                    </div>
                    <div class="col-sm-4"><%-- product image column --%>
                        <asp:Image ID="imgProduct" runat="server" />
                    </div>
                </div><%-- end of row 1 --%>

                <div class="row"><%-- row 2 --%>
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="col-sm-1">Quantity:</label>
                            <div class="col-sm-3">
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-8">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger"
                                    runat="server" ControlToValidate="txtQuantity" Display="Dynamic" 
                                    ErrorMessage="Quantity is a required field."></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" CssClass="text-danger" 
                                    ControlToValidate="txtQuantity" Display="Dynamic" 
                                    ErrorMessage="Quantity must range from 1 to 500."
                                    MaximumValue="500" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <br />
                                <asp:Button ID="btnAdd" runat="server" Text="Add to Cart" onclick="btnAdd_Click" CssClass="btn btn-success" />
                                <asp:Button ID="btnCart" runat="server" Text="Go to Cart" PostBackUrl="~/Cart.aspx" CausesValidation="False" CssClass="btn btn-warning" />
                            </div>
                        </div>
                    </div>
                </div>

           
        </main>
    </div>
</asp:Content>
