using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Jayrajsinh_BookStore
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private Book selectedBook;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string firstName = Session["FirstName"] as string;
                if (!string.IsNullOrEmpty(firstName))
                {
                    litWelcomeMessage.Text = "Welcome " + firstName;
                }
                else
                {
                    litWelcomeMessage.Text = "Welcome User";
                }
                ddlBooks.DataBind();
            }
            selectedBook = GetSelectedBook();
            if (selectedBook != null)
            {
                book_title.Text = selectedBook.book_title;
                description.Text = selectedBook.description;
                author.Text = selectedBook.author;
                lblUnitPrice.Text = selectedBook.price.ToString() + " each";
                imgProduct.ImageUrl = "Images/Books/" + selectedBook.image_url;
            }
        }

        private Book GetSelectedBook()
        {
            try
            {
                DataView BooksTable = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                BooksTable.RowFilter = "book_id = '" + ddlBooks.SelectedValue + "'";
                if (BooksTable.Count > 0)
                {
                    DataRowView row = BooksTable[0];
                    Book book = new Book
                    {
                        book_id = row["book_id"].ToString(),
                        book_title = row["book_title"].ToString(),
                        description = row["description"].ToString(),
                        author = row["author"].ToString(),
                        price = Convert.ToDecimal(row["price"]),
                        image_url = row["image_url"].ToString()
                    };
                    return book;
                }
                return null;
            }
            catch (Exception)
            {

                return null;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    int quantity = Convert.ToInt32(txtQuantity.Text);
                    CartItemList cart = CartItemList.GetCart();
                    CartItem cartItem = cart[selectedBook.book_id];

                    if (cartItem == null)
                    {
                        cart.AddItem(selectedBook, quantity);
                    }
                    else
                    {
                        cartItem.AddQuantity(quantity);
                    }
                    Response.Redirect("Cart.aspx");
                }
                catch (FormatException)
                {

                }
            }
        }
    }
}
