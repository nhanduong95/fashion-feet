using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ClientSide.Models;
using System.Data.Entity;

namespace ClientSide.Controllers
{
    public class OrdersController : Controller
    {
        private FashionFeetEntities db = new FashionFeetEntities();
        [Authorize]
        public ActionResult CheckOut()
        {
            if(Session["cart"] == null)
                return View("EmptyCartError");
            else
            {
                Order order = new Order();
                order.ClientName = User.Identity.Name;
                decimal amountPaid = 0;
                order.Cart = (List<CartItem>)Session["cart"];
                foreach (CartItem item in order.Cart)
                    amountPaid = item.ItemQuan * item.PricePerItem;
                order.TotalPayment = amountPaid;
                return View(order);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CheckOut ([Bind(Include ="ClientName, ClientPhone, ClientAddress, ClientCreditCardNo, ClientCreditCardOwner, Cart, TotalPayment, DateBought")] Order clientOrder)
        {
            if (Session["cart"] != null)
            {
                clientOrder.Cart = (List<CartItem>)Session["cart"];
                foreach(var cartItem in clientOrder.Cart)
                {
                    var product = db.Products.Find(cartItem.ItemId);
                    if (cartItem.ItemSize == 36)
                        product.ProdSize36Quan -= cartItem.ItemQuan;
                    else if (cartItem.ItemSize == 37)
                        product.ProdSize37Quan -= cartItem.ItemQuan;
                    else if (cartItem.ItemSize == 38)
                        product.ProdSize38Quan -= cartItem.ItemQuan;
                    else
                        product.ProdSize39Quan -= cartItem.ItemQuan;
                    db.Entry(product).State = EntityState.Modified;
                    db.SaveChanges();
                }
                clientOrder.DateBought = DateTime.Now;
                Session["cart"] = null;
                Session["order"] = clientOrder;

                return View("Summary");
            }
            else
                return View("EmptyCartError");
        }
    }
}