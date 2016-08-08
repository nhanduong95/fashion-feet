using System.Collections.Generic;

namespace ClientSide.Models
{
    public class ProdDetailsDisplay
    {
        public List<Product>relatedProds { get; set; }
        public Product displayProd { get; set; } 
    }
}