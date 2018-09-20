<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Index.master" AutoEventWireup="false"
    CodeFile="index.aspx.cs" Inherits="Pizza" %>
<%@ Import Namespace ="System.Data" %>
<%@ Import Namespace ="System.Data.SqlClient" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Label ID="Label1" runat="server" Text="Cart is Empty" Font-Bold ="True"> </asp:Label>
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/ViewCart.aspx">View Cart</asp:HyperLink>
        <asp:DataList ID="DataList1" runat="server" DataKeyField="MenuItemID" 
            onitemdatabound="DataList1_ItemDataBound1" >
            <FooterStyle BackColor="#CCCCCC" /><ItemStyle BackColor="White" />
         <SeparatorStyle VerticalAlign="Middle" />     <SelectedItemStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
         <SeparatorTemplate>
         </SeparatorTemplate>
         <HeaderStyle BackColor="Black" Font-Bold ="true" ForeColor="White" 
            Font-Italic="False" Font-Names="Comic Sans MS" Font-Overline="False" 
            Font-Strikeout="False" Font-Underline="False" />
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" 
                    ImageUrl='<%# Eval("Image", "Images/{0}") %>' />
                <br />
                <asp:Label ID="ItemNameLabel" runat="server" Text='<%# Eval("ItemName") %>' />
                <br />
                <asp:Label ID="DescriptionLabel" runat="server" 
                    Text='<%# Eval("Description") %>' />
                <br />
<br />
                <asp:Repeater ID="Repeater1" runat="server"
                DataSource='<%# ((DataRowView)Container.DataItem).CreateChildView("PizzaLink") %>'
                onitemcommand="Repeater1_ItemCommand">
                <ItemTemplate>
                <span style = "color:Blue"></span>
                <%# Eval ("ItemSize")%>: <%# Eval("Price", "£{0:F2}") %>

                <asp:LinkButton ID="OrderItem" runat="server" 
                CommandName='<%# Eval("ItemSize") %>' CommandArgument='<%# Eval("Price") %>'>
                    <asp:Image ID="CartIcon" runat="server" ImageUrl="Images/CartIcon1.gif" 
                    AlternateText="Add to Shopping Cart" />
                </asp:LinkButton> </span>
                </ItemTemplate>
                </asp:Repeater>
            </ItemTemplate>
        </asp:DataList>
        </asp:Content>