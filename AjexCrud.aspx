<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AjexCrud.aspx.cs" Inherits="Default_AjexCrud" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product CRUD</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // Retrieve product list
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetProductList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#productTable tbody").html(response.d);
                },
                error: function (xhr, status, error) {
                    console.error(error);
                }
            });

            // Insert product
            $("#btnInsert").click(function () {
                var productName = $("#txtProductName").val();
                var price = $("#txtPrice").val();
                
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/InsertProduct",
                    data: JSON.stringify({ productName: productName, price: price }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert(response.d);
                        // Refresh product list after insertion
                        $.ajax({
                            type: "POST",
                            url: "Default.aspx/GetProductList",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                $("#productTable tbody").html(response.d);
                            },
                            error: function (xhr, status, error) {
                                console.error(error);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                });
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <label for="txtProductName">Product Name:</label>
            <input type="text" id="txtProductName" />
            <br />
            <label for="txtPrice">Price:</label>
            <input type="text" id="txtPrice" />
            <br />
            <input type="button" id="btnInsert" value="Insert Product" />
            <br />
            <!-- Table to display products -->
            <table id="productTable" border="1">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Data will be populated here -->
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
