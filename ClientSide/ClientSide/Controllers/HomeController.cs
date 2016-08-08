using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ClientSide.Models;

namespace ClientSide.Controllers
{
    public class HomeController : Controller
    {
        private FashionFeetEntities db = new FashionFeetEntities();

        // GET: Categories
        public ActionResult Index()
        {
            return View(db.Categories.ToList());
        }
        public PartialViewResult _ProductsNavBar()
        {
            //if (Session["cart"] == null)
            //    ViewBag.CartItemQuan = 0;
            //else
            //{
            //    List<CartItem> cart = (List<CartItem>)Session["cart"];
            //    ViewBag.CartItemQuan = cart.Count;
            //}
            return PartialView(db.Categories.ToList());
        }
    }
}