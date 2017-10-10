﻿using mtv_management_leave.Lib.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using mtv_management_leave.Models;
using mtv_management_leave.Models.Entity;
using mtv_management_leave.Models.Response;

namespace mtv_management_leave.Lib.Repository
{
    public class LeaveTotalMonthly : Base, ILeaveTotalMonthly
    {
        LeaveManagementContext context;
        ICommonLeaveBase commonLeaveBase;

        public LeaveTotalMonthly()
        {
            commonLeaveBase = new CommonLeaveBase();
        }

        public List<LeaveMonthly> GetLastTotalMonthly(DateTime monthYear)
        {
            return PrivateGetLastTotalMonthly(monthYear, null);

        }

        public List<LeaveMonthly> GetLastTotalMonthly(DateTime monthYear, List<int> lstUid)
        {
            return PrivateGetLastTotalMonthly(monthYear, lstUid);
        }

        public List<LeaveMonthly> GetLastTotalMonthly(int year, int uid)
        {
            var lstResult = new List<LeaveMonthly>();
            InitContext(out context);
            lstResult = context.LeaveMonthlies.Where(m => m.Month.Year == year && m.Uid == uid).ToList();
            DisposeContext(context);
            return lstResult;
        }

        public void SaveLastTotalMonthly(DateTime MonthTo)
        {
            ExecuteSaveTotalMonthLeave(MonthTo, null);
        }

        public void SaveLastTotalMonthly(DateTime MonthTo, List<int> lstUid)
        {
            ExecuteSaveTotalMonthLeave(MonthTo, lstUid);
        }

        public void ReCalculateTotalMonthlyAllYear(DateTime MonthTo)
        {
            DateTime beginYear = new DateTime(MonthTo.Year, 1, 1);
            for (DateTime month = beginYear; month <= MonthTo; month = month.AddMonths(1))
            {
                ExecuteSaveTotalMonthLeave(month, null);
            }
        }

        public void ReCalculateTotalMonthlyAllYear(DateTime MonthTo, List<int> lstUid)
        {
            DateTime beginYear = new DateTime(MonthTo.Year, 1, 1);
            for (DateTime month = beginYear; month <= MonthTo; month = month.AddMonths(1))
            {
                ExecuteSaveTotalMonthLeave(month, lstUid);
            }
        }

        #region Private method - class

        private void ExecuteSaveTotalMonthLeave(DateTime MonthTo, List<int> lstUid)
        {

            InitContext(out context);

            var lstTotalMonthlyAlready_Query = context.LeaveMonthlies.Where(m => m.Month == MonthTo);
            if (lstUid != null && lstUid.Count > 0)
            {

                lstTotalMonthlyAlready_Query = lstTotalMonthlyAlready_Query.Where(m => lstUid.Contains(m.Uid));
            }
            var lstTotalMonthlyAlready = lstTotalMonthlyAlready_Query.ToList();

            var lstTotalLeave = commonLeaveBase.GetTotalLeaveMonthly(context, MonthTo, lstUid);
            foreach (var item in lstTotalLeave)
            {
                LeaveMonthly leaveMon = lstTotalMonthlyAlready.Where(m => m.Uid == item.Uid).FirstOrDefault();
                if (leaveMon == null)
                {
                    context.LeaveMonthlies.Add(item);
                }
                else
                {
                    leaveMon.LeaveAvailable = item.LeaveAvailable;
                    leaveMon.LeaveNonPaid = item.LeaveNonPaid;
                    leaveMon.LeaveRemain = item.LeaveRemain;
                    leaveMon.LeaveUsed = item.LeaveUsed;
                    leaveMon.Month = item.Month;
                }
            }
            context.SaveChanges();
            DisposeContext(context);
        }

        private List<LeaveMonthly> PrivateGetLastTotalMonthly(DateTime monthYear, List<int> lstUid)
        {
            var lstResult = new List<LeaveMonthly>();
            InitContext(out context);

            var query = context.LeaveMonthlies.Where(m => m.Month == monthYear);
            if (lstUid != null && lstUid.Count > 0)
            {
                query = query.Where(m => lstUid.Contains(m.Uid));
            }
            lstResult = query.ToList();
            DisposeContext(context);
            return lstResult;
        }

        //public List<ResponseLeaveTotalMonthly> GetTotalMonthlyBeginYear(DateTime monthYear, List<int> lstUid)
        //{
        //    List<ResponseLeaveTotalMonthly> result = new List<ResponseLeaveTotalMonthly>();
        //    var lstLeaveMonthly = new List<LeaveMonthly>();
        //    for (DateTime month = new DateTime(monthYear.Year,1,1); month<= monthYear; month= month.AddMonths(1))
        //    {
        //        lstLeaveMonthly.AddRange(PrivateGetLastTotalMonthly(month, lstUid));
        //    }
        //    result = lstLeaveMonthly.Select(m => new ResponseLeaveTotalMonthly() { FullName = m.UserInfo.FullName, Id = m.Id, LeaveAvailable = m.LeaveAvailable, LeaveNonPaid = m.LeaveNonPaid, LeaveRemain = m.LeaveRemain, LeaveUsed = m.LeaveUsed, Month = m.Month, Uid = m.Uid }).ToList();
        //    result = result.OrderBy(m => m.Uid).ThenBy(m => m.Month).ToList();
        //    return result;
        //}


        #endregion
    }
}