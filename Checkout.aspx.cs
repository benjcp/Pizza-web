using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Checkout : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void rdoList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = (RadioButtonList)sender;
        Panel ccp = (Panel)Wizard1.FindControl("CreditCardPayment");

        if (rbl.SelectedValue == "CC")
        {
            //ccp.Visible = true;
        }
        else
        {
            //ccp.Visible = false;
        }
    }
    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        //insert the order and order lines into database
        SqlConnection conn = null;
        SqlTransaction trans = null;
        SqlCommand cmd = default(SqlCommand);
        ShoppingCart cart = StoredCart.Read();

        // if there is not shopping cart, then something has gone wrong
        if (cart == null || cart.Items.Count == 0)
        {
            e.Cancel = true;
            return;
        }

        // try / catch protects us against exeptions
        try
        {
            int OrderID = 0;
            // Create and open a new connection to the database
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings
                ["ConnectionString"].ConnectionString);
            conn.Open();
            //start a new transaction
            trans = conn.BeginTransaction();
            //create a new command - the stored procedure
            cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.Transaction = trans;
            //set the order details: the name and type of the command
            cmd.CommandText = "AddOrder";
            cmd.CommandType = CommandType.StoredProcedure;
            //Set up the parameters to pass to the database

            cmd.Parameters.Add("@Name", SqlDbType.VarChar, 50);
            cmd.Parameters.Add("@Address", SqlDbType.VarChar, 50);
            cmd.Parameters.Add("@Email", SqlDbType.VarChar, 255);
            cmd.Parameters.Add("@OrderTime", SqlDbType.DateTime);
            cmd.Parameters.Add("@DeliveryCharge", SqlDbType.Money);
            cmd.Parameters.Add("@TotalValue", SqlDbType.Money);
            cmd.Parameters.Add("@CustomerRequest", SqlDbType.VarChar, 50);
            cmd.Parameters.Add("@OrderID", SqlDbType.Int);
           
            //set the values for the parameters

            cmd.Parameters["@Name"].Value = ((TextBox)Wizard1.FindControl("txtName")).Text;
            cmd.Parameters["@Address"].Value = ((TextBox)Wizard1.FindControl("txtAddress")).Text;
            cmd.Parameters["@Email"].Value = ((TextBox)Wizard1.FindControl("txtEmail")).Text;
            cmd.Parameters["@OrderTime"].Value = DateTime.Now;
            cmd.Parameters["@DeliveryCharge"].Value = cart.DeliveryCharge;
            cmd.Parameters["@TotalValue"].Value = cart.Total;
            cmd.Parameters["@CustomerRequest"].Value = "";
            cmd.Parameters["@OrderID"].Direction = ParameterDirection.Output;
            //Execute the query and parameters for the Order lines.
            cmd.ExecuteNonQuery();

            OrderID = Convert.ToInt32(cmd.Parameters["@OrderID"].Value);

            cmd.CommandText = "AddOrderItems";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("@fkOrderID", SqlDbType.Int);
            cmd.Parameters.Add("@fkMenuItemID", SqlDbType.Int);
            cmd.Parameters.Add("@fkItemSize", SqlDbType.VarChar, 10);
            cmd.Parameters.Add("@ItemName", SqlDbType.VarChar, 50);
            cmd.Parameters.Add("@Quantity", SqlDbType.Int);
            cmd.Parameters.Add("@SubTotal", SqlDbType.Money);
            cmd.Parameters["@fkOrderID"].Value = OrderID;
            // Loop through the items in the shopping cart adding each one
            foreach (CartItem item in cart.Items)
            {
                cmd.Parameters["@fkMenuItemID"].Value = item.MenuItemID;
                cmd.Parameters["@fkItemSize"].Value = item.ItemSize;
                cmd.Parameters["@ItemName"].Value = item.ItemName;
                cmd.Parameters["@Quantity"].Value = item.Quantity;
                cmd.Parameters["@SubTotal"].Value = item.SubTotal;

                cmd.ExecuteNonQuery();
            }
            //if no errors save to database and confirm onrder onscreen
            trans.Commit();
            lblSuccess.Visible = true;
        }
        catch(Exception)
        {
            if (trans != null)
            {
                trans.Rollback();
            }

            lblError.Visible = true;
            return;
        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
        cart.Items.Clear();
    }
}