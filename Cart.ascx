<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Cart.ascx.cs" Inherits="Cart" %>
<p>
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Checkout.aspx">Proceed to Checkout</asp:HyperLink>
</p>

<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
    DeleteMethod="DeleteItem" InsertMethod="InsertItem" SelectMethod="ReadItems" 
    TypeName="StoredCart" UpdateMethod="UpdateItem">
    <DeleteParameters>
        <asp:Parameter Name="MenuItemID" Type="Int32" />
        <asp:Parameter Name="Size" Type="String" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="MenuItemID" Type="Int32" />
        <asp:Parameter Name="ItemName" Type="String" />
        <asp:Parameter Name="ItemSize" Type="String" />
        <asp:Parameter Name="Quantity" Type="Int32" />
        <asp:Parameter Name="Price" Type="Decimal" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="MenuItemID" Type="Int32" />
        <asp:Parameter Name="ItemSize" Type="String" />
        <asp:Parameter Name="Quantity" Type="Int32" />
    </UpdateParameters>
</asp:ObjectDataSource>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="ObjectDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="MenuItemID" HeaderText="MenuItemID" 
            SortExpression="MenuItemID" ReadOnly="True" />
        <asp:BoundField DataField="ItemName" HeaderText="Name" 
            SortExpression="Name" ReadOnly="True" />
        <asp:BoundField DataField="ItemSize" HeaderText="Size" 
            SortExpression="Size" ReadOnly="True" />
        <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
            SortExpression="Quantity" />
        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" ReadOnly="True" />
        <asp:BoundField DataField="SubTotal" 
            HeaderText="SubTotal" ReadOnly="True" SortExpression="SubTotal" />
    </Columns>
    <EmptyDataTemplate>
        You have not ordered any items yet, &lt;<br />&gt;<br />
        Please visit the order pages to add items to the cart.
    </EmptyDataTemplate>
</asp:GridView>

