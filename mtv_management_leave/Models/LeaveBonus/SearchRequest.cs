﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.ModelBinding;

namespace mtv_management_leave.Models.LeaveBonus
{
    public class SearchRequest
    {
        [Display(Name = "Date start:")]
        public DateTime? DateStart { get; set; } 
        [Display(Name = "Date end:")]
        public DateTime? DateEnd { get; set; } 
        public List<int> Uids { get; set; }
        public int? Uid { get; set; }
    }
}