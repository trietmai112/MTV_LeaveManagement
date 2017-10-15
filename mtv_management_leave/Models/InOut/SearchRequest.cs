﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.ModelBinding;

namespace mtv_management_leave.Models.InOut
{
    public class SearchRequest
    {
        [Display(Name = "Date start:")]
        public DateTime DateStart { get; set; } = DateTime.Now;
        [Display(Name = "Date end:")]
        public DateTime DateEnd { get; set; } = DateTime.Now;
        public List<int> Uids { get; set; }
        public int? Uid { get; set; }
        public bool? InValidData { get; set; }
    }
}