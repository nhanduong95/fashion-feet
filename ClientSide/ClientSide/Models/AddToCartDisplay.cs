using System.Collections.Generic;

namespace ClientSide.Models
{
    public class AddToCartDisplay
    {
        public List<Product> relatedProds { get; set; }
        public CartItem cartItem { get; set; }
    }
}