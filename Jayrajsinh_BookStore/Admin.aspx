<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Jayrajsinh_BookStore.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Add Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" />

    <!-- DropDownList to display categories -->
    <div class="form-group">
        <label for="ddlCategories">Select Category:</label>
        <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged" 
                          DataSourceID="SqlDataSourceCategories" DataTextField="genre_name" DataValueField="genre_id" AppendDataBoundItems="true">
            <asp:ListItem Value="0" Text="Select a category" Selected="True"></asp:ListItem>
        </asp:DropDownList>
    </div>

    <!-- SqlDataSource to get categories -->
    <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                       SelectCommand="SELECT genre_id, genre_name FROM genre">
    </asp:SqlDataSource>

    <!-- GridView to display books based on selected category -->
    <asp:GridView ID="GridViewBooks" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceBooks" CssClass="table table-bordered table-striped">
        <Columns>
            <asp:BoundField DataField="book_id" HeaderText="ID" />
            <asp:BoundField DataField="book_title" HeaderText="Book Title" />
            <asp:BoundField DataField="author" HeaderText="Author" />
            <asp:BoundField DataField="price" HeaderText="Price" DataFormatString="{0:C}" />
        </Columns>
    </asp:GridView>

    <!-- SqlDataSource to get books based on selected category -->
    <asp:SqlDataSource ID="SqlDataSourceBooks" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                       SelectCommand="SELECT book_id, book_title, author, price FROM book WHERE genre_id = @genre_id">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCategories" Name="genre_id" PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>

    <!-- GridView to display and manage categories -->
    <asp:GridView ID="GridViewCategories" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceManageCategories" CssClass="table table-bordered table-striped" AllowPaging="True" PageSize="10" DataKeyNames="genre_id" OnRowUpdating="GridViewCategories_RowUpdating" OnRowDeleting="GridViewCategories_RowDeleting" OnRowEditing="GridViewCategories_RowEditing" OnRowCancelingEdit="GridViewCategories_RowCancelingEdit">
        <Columns>
            <asp:BoundField DataField="genre_id" HeaderText="ID" ReadOnly="True" />
            <asp:TemplateField HeaderText="Genre Name">
                <ItemTemplate>
                    <%# Eval("genre_name") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtGenreName" runat="server" Text='<%# Bind("genre_name") %>' CssClass="form-control" />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>

    <!-- SqlDataSource to manage categories -->
    <asp:SqlDataSource ID="SqlDataSourceManageCategories" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                       SelectCommand="SELECT genre_id, genre_name FROM genre"
                       UpdateCommand="UPDATE genre SET genre_name = @genre_name WHERE genre_id = @genre_id"
                       DeleteCommand="DELETE FROM genre WHERE genre_id = @genre_id"
                       InsertCommand="INSERT INTO genre (genre_id, genre_name) VALUES (@genre_id, @genre_name)">
        <UpdateParameters>
            <asp:Parameter Name="genre_name" Type="String" />
            <asp:Parameter Name="genre_id" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="genre_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="genre_id" Type="Int32" />
            <asp:Parameter Name="genre_name" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

    <div class="form-group mt-4">
        <label for="txtNewCategoryName">Add New Category:</label>
        <asp:TextBox ID="txtNewCategoryName" runat="server" CssClass="form-control" />
        <asp:Button ID="btnAddCategory" runat="server" Text="Add Category" CssClass="btn btn-primary mt-2" OnClick="btnAddCategory_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="text-success" />
    </div>





<!-- Details Panel for Adding/Editing Books -->
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8">
            <!-- GridView to display all books with pagination -->
            <h3>All Books</h3>
            <asp:SqlDataSource ID="SqlDataSourceAllBooks" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                               SelectCommand="SELECT book_id, book_title, author FROM book">
            </asp:SqlDataSource>

            <asp:GridView ID="GridViewAllBooks" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceAllBooks" CssClass="table table-bordered table-striped"
                          AllowPaging="True" PageSize="10" OnPageIndexChanging="GridViewAllBooks_PageIndexChanging" OnRowCommand="GridViewAllBooks_RowCommand">
                <Columns>
                    <asp:BoundField DataField="book_id" HeaderText="ID" />
                    <asp:BoundField DataField="book_title" HeaderText="Title" />
                    <asp:BoundField DataField="author" HeaderText="Author" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnView" runat="server" CommandName="View" CommandArgument='<%# Eval("book_id") %>' Text="View" CssClass="btn btn-info btn-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- Details Panel -->
        <div class="col-md-4">
            <div id="pnlBookDetails" runat="server" CssClass="card mt-4" Visible="false">
                <div class="card-header">
                    <h5 class="card-title">Book Details</h5>
                </div>
                <div class="card-body">
                    <asp:HiddenField ID="hfBookId" runat="server" />
                    
                    <div class="form-group">
                        <label for="txtBookTitle">Title:</label>
                        <asp:TextBox ID="txtBookTitle" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="txtAuthor">Author:</label>
                        <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="txtPrice">Price:</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="txtDescription">Description:</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-control" />
                    </div>

                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger" OnClick="btnDelete_Click" />
                    <asp:Button ID="btnAddNew" runat="server" Text="Add New" CssClass="btn btn-success" OnClick="btnAddNew_Click" />
                    
                    <asp:Label ID="Label1" runat="server" CssClass="text-success mt-2" />
                </div>
            </div>
        </div>
    </div>
</div>



</asp:Content>