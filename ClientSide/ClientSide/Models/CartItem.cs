using System;
using System.ComponentModel.DataAnnotations;

namespace ClientSide.Models
{
    public class CartItem
    {
        public string ItemName { get; set; }
        public string ItemId { get; set; }
        public decimal PricePerItem { get; set; }

        [Required(ErrorMessage ="*Required")]
        [Range(36, 39, ErrorMessage ="The value must be between 36 and 39.")]
        public int ItemSize { get; set; }

        [Required(ErrorMessage = "*Required")]
        [Range(1, 100, ErrorMessage = "The value must be between 1 and 100.")]
        public int ItemQuan { get; set; }
        public CartItem()
        {

        }
        public CartItem(string itemId, string itemName, decimal pricePerItem, int itemSize, int itemQuan)
        {
            this.ItemId = itemId;
            this.ItemName = itemName;
            this.PricePerItem = pricePerItem;
            this.ItemSize = itemSize;
            this.ItemQuan = itemQuan;
         }
    }

}