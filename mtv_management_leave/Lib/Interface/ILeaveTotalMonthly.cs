﻿using mtv_management_leave.Models;
using mtv_management_leave.Models.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mtv_management_leave.Lib.Interface
{
    /// <summary>
    /// Summerize tổng leave cho từng tháng
    /// </summary>
    interface ILeaveTotalMonthly
    {
        void GetLastTotalMonthly(int year);
        void GetLastTotalMonthly(int year, int uid);

        void SaveLastTotalMonthly(DateTime MonthTo);
        void SaveLastTotalMonthly(DateTime MonthTo, int uid);

        /// <summary>
        /// Hàm tính lại từ đầu Năm
        /// </summary>
        void ReCalculateTotalMonthly(DateTime MonthTo);
        void ReCalculateTotalMonthly(DateTime MonthTo, int uid);

        /// <summary>
        /// Hàm tính tổng kết leave tháng hiện tại
        /// </summary>
        /// <param name="MonthYear"></param>
        void CalculateTotalMonthly(DateTime MonthYear);
        void CalculateTotalMonthly(DateTime MonthYear, int uid);

    }
}