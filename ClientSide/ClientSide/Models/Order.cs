using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ClientSide.Models
{
    public class Order
    {
        [Display(Name = "User Name")]
        public string ClientName { get; set; }

        [Required (ErrorMessage ="The field is required.")]
        [RegularExpression (@"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$", 
            ErrorMessage = "Invalid Phone Number.")]
        [Display(Name ="Phone Number")]
        public string ClientPhone { get; set; }

        [Required (ErrorMessage = "The field is required.")]
        [Display(Name = "Address")]
        public string ClientAddress { get; set; }

        [Required(ErrorMessage = "The field is required.")]
        [Display(Name = "Credit Card Number")]
        [RegularExpression(@"^(?:(4[0-9]{12}(?:[0-9]{3})?)|(5[1-5][0-9]{14})|
                                (6(?:011|5[0-9]{2})[0-9]{12})|(3[47][0-9]{13})|
                                (3(?:0[0-5]|[68][0-9])[0-9]{11})|((?:2131|1800|35[0-9]{3})[0-9]{11}))$",
                            ErrorMessage = "Invalid credit card number.")]
        public string ClientCreditCardNo { get; set; }

        [Required (ErrorMessage = "The field is required.")]
        [Display(Name = "Card Owner")]
        public string ClientCreditCardOwner { get; set; }

        public List<CartItem> Cart { get; set; }

        [Display(Name = "Total Payment")]
        public decimal TotalPayment { get; set; }

        public DateTime DateBought { get; set; }

        public Order()
        {

        }
        public Order(string phoneNo, string address, string creditCardNo, 
            string creditCardOwner, List<CartItem> cart, decimal totalPayment)
        {
            ClientPhone = phoneNo;
            ClientAddress = address;
            ClientCreditCardNo = creditCardNo;
            ClientCreditCardOwner = creditCardOwner;
            Cart = cart;
            TotalPayment = totalPayment;
            DateBought = DateTime.Now;
        }
    }
}