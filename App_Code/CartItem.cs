using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CartItem
/// </summary>
public class CartItem
{
    private int _MenuItemID;
    private string _ItemName;
    private string _ItemSize;
    private int _Quantity;

    private decimal _Price;
    //empty cart item
    public CartItem()
    {

    }
    //new cart item
    public CartItem(int MenuItemID, string ItemName, string ItemSize, int Quantity, decimal Price)
    {
        //initialize the private member variables
        _MenuItemID = MenuItemID;
        _ItemName = ItemName;
        _ItemSize = ItemSize;
        _Quantity = Quantity;
        _Price = Price;
    }

    public int MenuItemID
    {
        get { return _MenuItemID; }
        set { _MenuItemID = value; }
    }

    public string ItemName
    {
        get { return _ItemName; }
        set { _ItemName = value; }
    }

    public string ItemSize
    {
        get { return _ItemSize; }
        set { _ItemSize = value; }
    }

    public int Quantity
    {
        get { return _Quantity; }
        set { _Quantity = value; }
    }

    public decimal Price
    {
        get { return _Price; }
        set { _Price = value; }
    }


    public decimal SubTotal
    {
        get { return _Quantity * _Price; }
    }
}