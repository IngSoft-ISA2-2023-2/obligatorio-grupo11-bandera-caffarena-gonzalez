﻿using PharmaGo.Exceptions;

namespace PharmaGo.Domain.Entities
{
    public class Product
    {
        public int Id { get; set; }
        public int Code { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public bool Deleted { get; set; }
        public Pharmacy? Pharmacy { get; set; }

        public void ValidOrFail()
        {
            if (string.IsNullOrEmpty(Code.ToString()) || string.IsNullOrEmpty(Name) || string.IsNullOrEmpty(Description)
                    || Price <= 0 || Code.ToString().Length != 5 || Name.Length > 30 || Description.Length > 70)
            {
                throw new InvalidResourceException("The Product is not correctly created.");
            }
        }
    }
}
