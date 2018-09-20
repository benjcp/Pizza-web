using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class Pizza : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        string sqlPizza = "SELECT MenuItemID, ItemName, Description, " +
            "Image FROM MenuItems";

        string sqlSizePrice = "SELECT fkMenuItemID, ItemSize, Price " +
        "FROM PriceandSize INNER JOIN MenuItems On MenuItems.MenuItemID = PriceandSize.fkMenuItemID " +
        "ORDER BY Price DESC";

        string ConnectSQLshop = ConfigurationManager.ConnectionStrings
            ["ConnectionString"].ConnectionString;

        using (SqlConnection con = new SqlConnection(ConnectSQLshop))
        {
            SqlDataAdapter da = new SqlDataAdapter(sqlPizza, con);
            try
            {
                da.Fill(ds, "MenuItems");
                da.SelectCommand.CommandText = sqlSizePrice;
                da.Fill(ds, "SizeAndPrice");
            }
            catch (Exception ex)
            {
                Label1.Text = "ERROR: " + ex.Message;

                return;
            }
        }

        DataColumn pkcol = ds.Tables["MenuItems"].Columns["MenuItemID"];
        DataColumn fkcol = ds.Tables["SizeAndPrice"].Columns["fkMenuItemID"];
        DataRelation dr = new DataRelation("PizzaLink", pkcol, fkcol);
        ds.Relations.Add(dr);

        DataList1.DataSource = ds;
        DataList1.DataMember = "MenuItems";
        DataList1.DataBind();

    }
    protected void DataList1_ItemDataBound1(object sender, DataListItemEventArgs e)

    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater rpt = (Repeater)e.Item.FindControl("Repeater1");
            HiddenField ItemID = new HiddenField();
            HiddenField Item = new HiddenField();

            ItemID.ID = "ItemID";
            Item.ID = "Item";

            ItemID.Value = DataBinder.Eval(e.Item.DataItem, "MenuItemID").ToString();
            Item.Value = (string)DataBinder.Eval(e.Item.DataItem, "ItemName");

            rpt.Controls.Add(ItemID);
            rpt.Controls.Add(Item);
        }
    }

    public Pizza()
    {
        Load += Page_Load;
    }

    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        Repeater rpt = (Repeater)source;
        HiddenField IDControl = (HiddenField)rpt.FindControl("ItemID");
        HiddenField NameControl = (HiddenField)rpt.FindControl("Item");

        int MenuItemID = Convert.ToInt32(IDControl.Value);
        string ItemName = NameControl.Value;
        string ItemSize = e.CommandName.ToString();
        decimal Price = Convert.ToDecimal(e.CommandArgument);
        StoredCart.InsertItem(MenuItemID, ItemName, ItemSize, 1, Price);
        Label1.Text = string.Format("{0} ({1}) added to the shopping cart", ItemName, ItemSize);
    }

}
