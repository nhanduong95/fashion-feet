using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using ClientSide.Models;

namespace ClientSide.Controllers
{
    public class CartsController : Controller
    {
        private FashionFeetEntities db = new FashionFeetEntities();
        public PartialViewResult _CartNavBar()
        {
            ViewBag.CartItemQuan = CountCartItem();
            return PartialView("_CartNavBar");
        }
        [HttpGet]
        public ActionResult AddToCart(string prodId, string prodName,
            string prodCateId, decimal prodPrice, string prodImage)
        {
            ViewBag.ImageUrl = prodImage;
            var addToCartDisplay = new AddToCartDisplay();
            addToCartDisplay.cartItem = new CartItem();
            addToCartDisplay.cartItem.ItemId = prodId;
            addToCartDisplay.cartItem.ItemName = prodName;
            addToCartDisplay.cartItem.PricePerItem = prodPrice;
            addToCartDisplay.cartItem.ItemSize = 36;
            addToCartDisplay.cartItem.ItemQuan = 1;
            addToCartDisplay.relatedProds = db.Products.Include(p => p.Category).
                                                Where(p => p.Category.CateId.Equals(prodCateId)).ToList();
            return View(addToCartDisplay);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddToCart([Bind(Include = "itemId, itemName, pricePerItem, itemSize, itemQuan")] CartItem cartItem)
        {
            if (ModelState.IsValid == false)
                return View("CartInvalidInputError");
            var prod = db.Products.Find(cartItem.ItemId);
            if (prod == null)
                return HttpNotFound();
            if ((cartItem.ItemSize == 36 && cartItem.ItemQuan > prod.ProdSize36Quan)
                || (cartItem.ItemSize == 37 && cartItem.ItemQuan > prod.ProdSize37Quan)
                || (cartItem.ItemSize == 38 && cartItem.ItemQuan > prod.ProdSize38Quan)
                || (cartItem.ItemSize == 39 && cartItem.ItemQuan > prod.ProdSize39Quan))
            {
                return View("UnavailableQuantityError");
            }
            else
            {
                List<CartItem> cart;
                if (Session["cart"] == null)
                {
                    cart = new List<CartItem>();
                    cart.Add(cartItem);
                    Session["cart"] = cart;
                }
                else
                {
                    cart = (List<CartItem>)Session["cart"];
                    int index = IsPresent(cartItem.ItemId, cartItem.ItemSize);
                    if (index == -1)
                    {
                        cart.Add(cartItem);
                    }
                    else
                        cart[index].ItemQuan += cartItem.ItemQuan;
                    Session["cart"] = cart;
                }
                ViewBag.CartItemQuan = CountCartItem();
                ViewBag.TotalPaidAmount = TotalPaidAmount();
                return RedirectToAction("Details", "Products", new
                {
                    prodId = prod.ProdId,
                    prodName = prod.ProdName,
                    prodCateId = prod.CateId
                });
            }

        }
        //Return index if item already in cart, -1 otherwise
        private int IsPresent(string itemId, int itemSize)
        {
            List<CartItem> cart = (List<CartItem>)Session["cart"];
            for (int i = 0; i < cart.Count; i++)
                if (cart[i].ItemId == itemId && cart[i].ItemSize == itemSize)
                    return i;
            return -1;
        }
        public int CountCartItem()
        {
            if (Session["cart"] == null)
                return 0;
            else
            {
                List<CartItem> cart = (List<CartItem>)Session["cart"];
                return cart.Count;
            }
        }
        public decimal TotalPaidAmount()
        {
            if (Session["cart"] == null)
                return 0;
            else
            {
                List<CartItem> cart = (List<CartItem>)Session["cart"];
                decimal paidAmount = 0;
                foreach (CartItem item in cart)
                    paidAmount += (item.PricePerItem * item.ItemQuan);
                return paidAmount;
            }
        }
        public ActionResult ViewCart()
        {
            List<CartItem> cart;
            if (Session["cart"] == null)
            {
                cart = new List<CartItem>();
                Session["cart"] = cart;
            }
            cart = (List<CartItem>)Session["cart"];
            ViewBag.CartItemQuan = CountCartItem();
            ViewBag.TotalPaidAmount = TotalPaidAmount();
            return View("ViewCart");
        }
        public ActionResult Remove(string itemId, int itemSize)
        {
            if (itemId == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(itemId);
            if (product == null)
            {
                return HttpNotFound();
            }

            int index = IsPresent(itemId, itemSize);
            List<CartItem> cart = (List<CartItem>)Session["cart"];
            cart.RemoveAt(index);
            Session["cart"] = cart;
            return View("ViewCart");
        }
    }
}