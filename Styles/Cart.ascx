<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Cart.ascx.cs" Inherits="Cart" %>
<p>
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Checkout.aspx">Proceed to Checkout</asp:HyperLink>
</p>

<asp:ObjectDataSource runat="server" ID="ObjectDataSource1" 
    DeleteMethod="DeleteItem" InsertMethod="InsertItem" SelectMethod="ReadItems" 
    TypeName="StoredCart" UpdateMethod="UpdateItem">
    <DeleteParameters>
    <asp:Parameter Name="MenuItemID" Type="Int32" />
    <asp:Parameter Name="Size" Type="String" />
    </DeleteParameters>

    <InsertParameters>
    <asp:Parameter Name="MenuItemID" Type="Int32" />
    <asp:Parameter Name="Name" Type="String" />
    <asp:Parameter Name="Size" Type="String" />
    <asp:Parameter Name="Quantity" Type="Int32" />
    <asp:Parameter Name="Price" Type="Decimal" />
    </InsertParameters>

    <UpdateParameters>
    <asp:Parameter Name="MenuItemID" Type="Int32" />
    <asp:Parameter Name="Size" Type="String" />
    <asp:Parameter Name="Quantity" Type="Int32" />
    </UpdateParameters>

</asp:ObjectDataSource>

<asp:gridview ID="Gridview1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="ObjectDataSource1">
    <Columns>
     <asp:BoundField DataField="MenuItemID" HeaderText="MenuItemID" 
            SortExpression="MenuItemID" />
        <asp:BoundField DataField="Name" HeaderText="Name" 
            SortExpression="Name" />
        <asp:BoundField DataField="Size" HeaderText="Size" 
            SortExpression="Size" />
        <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
            SortExpression="Quantity" />
        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
        <asp:BoundField DataField="SubTotal" 
            HeaderText="SubTotal" ReadOnly="True" SortExpression="SubTotal" />
    </Columns>
        <EmptyDataTemplate>
        You have not ordered any items yet, &lt;br /&gt;<br />
        Please visit the order pages to add items to the cart.
    </EmptyDataTemplate>
</asp:gridview>
