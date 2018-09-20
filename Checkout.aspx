<%@ Page Title="" Language="C#" MasterPageFile="~/Index.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Checkout" %>

<%@ Register src="Cart.ascx" tagname="Cart" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Wizard ID="Wizard1" runat="server" 
        onfinishbuttonclick="Wizard1_FinishButtonClick" Width="100%" 
        ActiveStepIndex="2" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderWidth="1px" 
        Font-Names="Verdana" Font-Size="0.8em">

        <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" 
            BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="White" 
            HorizontalAlign="Center" />
        <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" 
            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" 
            ForeColor="#284E98" />
        <SideBarButtonStyle BackColor="#507CD1" BorderColor="#006699" 
            Font-Names="Verdana" ForeColor="White" />
        <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
        <StepStyle Font-Names="Verdana" Font-Size="0.8em" ForeColor="#333333" />
        
        <WizardSteps>
            <asp:WizardStep ID="WizardStep1" runat="server" Title="Delivery Address" StepType="Start">
            <table style="width: 100%; height:100%;" border="0" cellpadding="3">
            <tr>
                <td style="width:200px" valign="top">
                  Name
                </td>
                <td style="width: 400px" valign="top">
                    <asp:TextBox ID="txtName" runat="server" Width="300px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 200px" valign="top"> Address
                </td>
                <td style="width: 200px" valign="top">
                    <asp:TextBox ID="txtAddress" runat="server" Width="300"
                    Columns="30" Rows="5" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width:200px" valign="top"> E-Mail
                </td>
                <td style="width: 400px" valign="top">
                     <asp:TextBox ID="txtEmail" runat="server" Width="300px"></asp:TextBox>
                </td>
            </tr>
             <tr>
                <td style="width:200px" valign="top"></td>
                <td style="width: 400px" valign="top"></td>
            </tr>
        </table>
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep2" runat="server" Title="Payment"><asp:RadioButtonList runat="server" 
                    ID="rdoList1" AutoPostBack="True" 
                    OnSelectedIndexChanged="rdoList1_SelectedIndexChanged">
                <asp:ListItem Selected="True" Value="CaOD">Delivery</asp:ListItem>
                <asp:ListItem Value="CC">Collection</asp:ListItem>
            </asp:RadioButtonList>
                
            </asp:WizardStep>

            <asp:WizardStep ID="WizardStep3" runat="server" StepType="Finish" Title="Shopping Cart">
                
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                    DeleteMethod="DeleteItem" InsertMethod="InsertItem" SelectMethod="ReadItems" 
                    TypeName="StoredCart" UpdateMethod="UpdateItem">
                    <DeleteParameters>
                        <asp:Parameter Name="MenuItemID" Type="Int32" />
                        <asp:Parameter Name="ItemSize" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="MenuID" Type="Int32" />
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
                    DataSourceID="ObjectDataSource1">
                    <Columns>
                        <asp:BoundField DataField="ItemName" HeaderText="Name" SortExpression="ItemName" />
                        <asp:BoundField DataField="ItemSize" HeaderText="Size" 
                            SortExpression="Size" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                            SortExpression="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                        <asp:BoundField DataField="SubTotal" HeaderText="SubTotal" ReadOnly="True" 
                            SortExpression="SubTotal" />
                    </Columns>
                    <EmptyDataTemplate>
                        You have not ordered any items yet,
                        <br> Please visit the order pages to 
                        add items to the cart.
                    </EmptyDataTemplate>
                </asp:GridView>
                
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="Read" 
                    TypeName="StoredCart"></asp:ObjectDataSource>
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                    DataSourceID="ObjectDataSource2" Height="50px" Width="125px">
                    <Fields>
                        <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" 
                            SortExpression="Total" />
                        <asp:BoundField DataField="DeliveryCharge" HeaderText="DeliveryCharge" 
                            SortExpression="DeliveryCharge" />
                    </Fields>
                </asp:DetailsView>
                <br />
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep4" runat="server" StepType="Complete" Title="Order Complete">
            Thank you for your order<br />
                <asp:Label ID="lblSuccess" runat="server" 
                    Text="Your order has been processed successfully. Please allow 30 mins for delivery." 
                    Visible="False"></asp:Label>
                <br />
                <asp:Label ID="lblError" runat="server" 
                    Text="Sorry, we were unable to complete your order at this time. Please try again later." 
                    Visible="False"></asp:Label>
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>
</asp:Content>
