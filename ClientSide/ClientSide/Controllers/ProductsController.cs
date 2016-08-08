using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using ClientSide.Models;
using PagedList;

namespace ClientSide.Controllers
{
    public class ProductsController : Controller
    {
        private FashionFeetEntities db = new FashionFeetEntities();
        // GET: Products
        public ActionResult Index(string cateId, string cateName, int? pageNo)
        {
            if (cateId == null || cateName == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var products = db.Products.Include(p => p.Category).
                Where(p => p.Category.CateId.Equals(cateId)).OrderBy(p => p.ProdPrice);
            ViewBag.ProdTypeId = cateId;
            ViewBag.ProdTypeName = cateName;
            int sizeOfPage = 20;
            int noOfPage = (pageNo ?? 1);
            return View(products.ToPagedList(noOfPage, sizeOfPage));
        }
        // GET: Products/Details/5
        public ActionResult Details(string prodId, string prodName, string prodCateId)
        {
            if (prodId == null || prodName == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var prodDetailsDisplay = new ProdDetailsDisplay();
            Product product = db.Products.Find(prodId);
            
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.ProdName = prodName;
            prodDetailsDisplay.displayProd = product;
            prodDetailsDisplay.relatedProds = db.Products.Include(p => p.Category).
                                                Where(p => (p.Category.CateId.Equals(prodCateId) && p.ProdId.Equals(prodId) == false)).ToList();
            
            return View(prodDetailsDisplay);
        }
        
    }
}
