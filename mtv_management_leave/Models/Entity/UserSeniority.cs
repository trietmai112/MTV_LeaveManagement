//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace mtv_management_leave.Models.Entity
{
    using System;
    using System.Collections.Generic;
    
    public partial class UserSeniority
    {
        public int Id { get; set; }
        public int Uid { get; set; }
        public Nullable<int> Year { get; set; }
        public Nullable<byte> Month1 { get; set; }
        public Nullable<byte> Month2 { get; set; }
        public Nullable<byte> Month3 { get; set; }
        public Nullable<byte> Month4 { get; set; }
        public Nullable<byte> Month5 { get; set; }
        public Nullable<byte> Month6 { get; set; }
        public Nullable<byte> Month7 { get; set; }
        public Nullable<byte> Month8 { get; set; }
        public Nullable<byte> Month9 { get; set; }
        public Nullable<byte> Month10 { get; set; }
        public Nullable<byte> Month11 { get; set; }
        public Nullable<byte> Month12 { get; set; }
        public int UserCreated { get; set; }
        public int UserUpdated { get; set; }
        public System.DateTime DateCreated { get; set; }
        public System.DateTime DateUpdated { get; set; }
    
        public virtual User User { get; set; }
    }
}
