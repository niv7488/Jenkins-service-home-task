using Microsoft.AspNetCore.Mvc;

namespace MyNetCoreApp.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
