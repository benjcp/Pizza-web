using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ShoppingCart
/// </summary>
public class ShoppingCart
{
    private List<CartItem> _items;

    public ShoppingCart()
    {
        if (_items == null)
        {
            _items = new List<CartItem>();
        }
    }
    public List<CartItem> Items
    {
        get { return _items; }
    }
    public decimal Total
    {
        get
        {
            decimal functionReturnValue = default(decimal);
            // adding each SubTotal to the Total
            foreach (CartItem item in _items)
            {
                functionReturnValue += item.SubTotal;
            }
            return functionReturnValue;
        }
    }
    private decimal _deliveryCharge = 3.5M;
    public decimal DeliveryCharge
    {
        get { return _deliveryCharge; }
        set { _deliveryCharge = value; }
    }

    private int ItemIndex(int MenuItemID, string ItemSize)
    {
        int index = 0;

        foreach (CartItem item in _items)
        {
            if (item.MenuItemID == MenuItemID && item.ItemSize == ItemSize)
            {
                return index;
            }
            index += 1;
        }
        return -1;

    }
    public void Insert(int MenuItemID, string ItemName, string ItemSize, int Quantity, decimal Price)
    {
        int idx = ItemIndex(MenuItemID, ItemSize);

        if (idx == -1)
        {
            CartItem NewItem = new CartItem();
            NewItem.MenuItemID = MenuItemID;
            NewItem.ItemName = ItemName;
            NewItem.ItemSize = ItemSize;
            NewItem.Price = Price;
            NewItem.Quantity = Quantity;
            _items.Add(NewItem);
        }
        else
        {
            _items[idx].Quantity += 1;
        }
    }

    public void Update(int MenuItemID, string ItemSize, int Quantity)
    {
        int idx = ItemIndex(MenuItemID, ItemSize);
        if (idx != -1)
        {
            _items[idx].Quantity = Quantity;
        }
    }

    public void Delete(int MenuItemID, string ItemSize)
    {
        int idx = ItemIndex(MenuItemID, ItemSize);
        if (idx != -1)
        {
            _items.RemoveAt(idx);
        }
    }
}
