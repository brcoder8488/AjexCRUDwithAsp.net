using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

    public partial class Default_AjexCrud : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Load initial data or perform any other setup
        }

        [WebMethod]
        public static string GetProductList()
        {
            string connectionString = "YourConnectionString"; // Replace with your actual connection string
            string query = "SELECT ProductID, ProductName, Price FROM Products";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable table = new DataTable();
                adapter.Fill(table);

                // Convert DataTable to HTML table
                string html = ConvertDataTableToHtml(table);
                return html;
            }
        }

        [WebMethod]
        public static string InsertProduct(string productName, decimal price)
        {
            string connectionString = "YourConnectionString"; // Replace with your actual connection string
            string query = "INSERT INTO Products (ProductName, Price) VALUES (@ProductName, @Price)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ProductName", productName);
                command.Parameters.AddWithValue("@Price", price);

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    return "Product inserted successfully.";
                }
                else
                {
                    return "Failed to insert product.";
                }
            }
        }

        private static string ConvertDataTableToHtml(DataTable table)
        {
            // Convert DataTable to HTML table
            // Implement your conversion logic here
            string html = "<tr><th>Product ID</th><th>Product Name</th><th>Price</th></tr>";
            foreach (DataRow row in table.Rows)
            {
                html += "<tr>";
                html += "<td>" + row["ProductID"] + "</td>";
                html += "<td>" + row["ProductName"] + "</td>";
                html += "<td>" + row["Price"] + "</td>";
                html += "</tr>";
            }
            return html;
        }
    }
