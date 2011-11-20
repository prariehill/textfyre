﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Textfyre.Website.Models;

namespace Textfyre.Website.Controllers
{
    public class GameController : Controller
    {
        //
        // GET: /Game/{Game}
        public ActionResult Index(string game)
        {
            GameViewData viewData = new GameViewData();
            viewData.Key = "10B0000000005";
            viewData.Name = "Cloak";
            viewData.Title = "Cloak of Darkness";
            viewData.Author = "Anonymous";
            viewData.Platform = "Inform 7";
            viewData.ImageURL = "~/Content/cloak-tile.png";
            viewData.Keywords = "example";
            viewData.Description = "Cloak of Darkness is a simple example that demonstrates implementations using different Interactive Fiction development platforms.";

            return View(viewData);
        }

    }
}