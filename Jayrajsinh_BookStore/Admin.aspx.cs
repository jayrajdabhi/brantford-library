using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Jayrajsinh_BookStore
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlCategories.DataBind();
            }
        }

        protected void ddlCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewBooks.DataBind();
        }

        protected void GridViewCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridViewCategories.Rows[e.RowIndex];
            TextBox txtGenreName = (TextBox)row.FindControl("txtGenreName");

            if (txtGenreName != null && !string.IsNullOrWhiteSpace(txtGenreName.Text))
            {
                try
                {
                    ExecuteNonQuery("UPDATE genre SET genre_name = @genre_name WHERE genre_id = @genre_id",
                        new SqlParameter("@genre_name", txtGenreName.Text),
                        new SqlParameter("@genre_id", GridViewCategories.DataKeys[e.RowIndex].Value));

                    GridViewCategories.EditIndex = -1;
                    GridViewCategories.DataBind();
                    lblMessage.Text = "Category updated successfully!";
                    lblMessage.CssClass = "text-success";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error updating category: " + ex.Message;
                    lblMessage.CssClass = "text-danger";
                }
            }
            else
            {
                lblMessage.Text = "Category name cannot be empty!";
                lblMessage.CssClass = "text-danger";
            }
        }

        protected void GridViewCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                object genreId = GridViewCategories.DataKeys[e.RowIndex]?.Value;

                if (genreId != null)
                {
                    ExecuteNonQuery("DELETE FROM genre WHERE genre_id = @genre_id",
                        new SqlParameter("@genre_id", Convert.ToInt32(genreId)));

                    GridViewCategories.DataBind();
                    lblMessage.Text = "Category deleted successfully!";
                    lblMessage.CssClass = "text-success";
                }
                else
                {
                    lblMessage.Text = "Error: Genre ID not found.";
                    lblMessage.CssClass = "text-danger";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error deleting category: " + ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtNewCategoryName.Text))
            {
                try
                {
                    int newGenreId = GetNextGenreId();

                    ExecuteNonQuery("INSERT INTO genre (genre_id, genre_name) VALUES (@genre_id, @genre_name)",
                        new SqlParameter("@genre_id", newGenreId),
                        new SqlParameter("@genre_name", txtNewCategoryName.Text));

                    txtNewCategoryName.Text = string.Empty;
                    lblMessage.Text = "Category added successfully!";
                    lblMessage.CssClass = "text-success";
                    GridViewCategories.DataBind();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error adding category: " + ex.Message;
                    lblMessage.CssClass = "text-danger";
                }
            }
            else
            {
                lblMessage.Text = "Category name cannot be empty!";
                lblMessage.CssClass = "text-danger";
            }
        }

        private int GetNextGenreId()
        {
            int nextId = 1; // Default value if table is empty

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT MAX(genre_id) FROM genre", connection))
                {
                    object result = command.ExecuteScalar();
                    if (result != DBNull.Value)
                    {
                        nextId = Convert.ToInt32(result) + 1;
                    }
                }
            }

            return nextId;
        }


        private void ExecuteNonQuery(string query, params SqlParameter[] parameters)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(parameters);
                    command.ExecuteNonQuery();
                }
            }
        }

        protected void GridViewCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewCategories.EditIndex = e.NewEditIndex;
            GridViewCategories.DataBind();
        }

        protected void GridViewCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewCategories.EditIndex = -1;
            GridViewCategories.DataBind();
        }

        protected void GridViewAllBooks_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewAllBooks.PageIndex = e.NewPageIndex;
            GridViewAllBooks.DataBind();
        }




        protected void GridViewAllBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int bookId = Convert.ToInt32(e.CommandArgument);
                ShowBookDetails(bookId);
            }
        }

        private void ShowBookDetails(int bookId)
        {
            // Fetch book details from the database
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT book_id, book_title, author, price, description FROM book WHERE book_id = @book_id";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@book_id", bookId);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfBookId.Value = reader["book_id"].ToString();
                            txtBookTitle.Text = reader["book_title"].ToString();
                            txtAuthor.Text = reader["author"].ToString();
                            txtPrice.Text = Convert.ToDecimal(reader["price"]).ToString("0.00");
                            txtDescription.Text = reader["description"].ToString();
                        }
                    }
                }
            }

            // Show the details panel
            pnlBookDetails.Visible = true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query;

            if (string.IsNullOrEmpty(hfBookId.Value))
            {
                // Add new book
                query = "INSERT INTO book (book_title, author, price, description) VALUES (@book_title, @author, @price, @description)";
            }
            else
            {
                // Update existing book
                query = "UPDATE book SET book_title = @book_title, author = @author, price = @price, description = @description WHERE book_id = @book_id";
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (!string.IsNullOrEmpty(hfBookId.Value))
                    {
                        command.Parameters.AddWithValue("@book_id", Convert.ToInt32(hfBookId.Value));
                    }
                    command.Parameters.AddWithValue("@book_title", txtBookTitle.Text);
                    command.Parameters.AddWithValue("@author", txtAuthor.Text);
                    command.Parameters.AddWithValue("@price", Convert.ToDecimal(txtPrice.Text));
                    command.Parameters.AddWithValue("@description", txtDescription.Text);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "Book details saved successfully!";
            lblMessage.CssClass = "text-success";
            GridViewAllBooks.DataBind(); // Refresh the GridView
            pnlBookDetails.Visible = false;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfBookId.Value))
            {
                lblMessage.Text = "No book selected for deletion.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "DELETE FROM book WHERE book_id = @book_id";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@book_id", Convert.ToInt32(hfBookId.Value));
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "Book deleted successfully!";
            lblMessage.CssClass = "text-success";
            GridViewAllBooks.DataBind(); // Refresh the GridView
            pnlBookDetails.Visible = false;
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            // Clear the fields to add a new book
            hfBookId.Value = string.Empty;
            txtBookTitle.Text = string.Empty;
            txtAuthor.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtDescription.Text = string.Empty;
            pnlBookDetails.Visible = true;
        }




    }
}

