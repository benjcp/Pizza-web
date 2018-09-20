<%@ Page Title="" Language="C#" MasterPageFile="~/Index.master" AutoEventWireup="true" CodeFile="ViewCart.aspx.cs" Inherits="_Default" %>

<%@ Register src="Cart.ascx" tagname="Cart" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<uc1:Cart ID="Cart1" runat="server" />

</asp:Content>
