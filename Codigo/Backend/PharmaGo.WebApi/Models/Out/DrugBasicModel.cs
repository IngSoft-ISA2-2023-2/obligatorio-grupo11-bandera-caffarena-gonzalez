﻿using PharmaGo.Domain.Entities;

namespace PharmaGo.WebApi.Models.Out
{
    public class DrugBasicModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string Symptom { get; set; }
        public PharmacyBasicModel Pharmacy { get; set; }

        public string Description { get; set; }
        public bool IsDrug { get; set; }


        public DrugBasicModel(Drug drug)
        {
            Id = drug.Id;
            Code = drug.Code;
            Name = drug.Name;
            Symptom = drug.Symptom;
            Price = drug.Price;
            Pharmacy = new PharmacyBasicModel(drug.Pharmacy);
            IsDrug = true;
        }

        public DrugBasicModel(Product prod)
        {
            Id = prod.Id;
            Code = prod.Code.ToString();
            Name = prod.Name;
            Description = prod.Description;
            Price = prod.Price;
            Pharmacy = new PharmacyBasicModel(prod.Pharmacy);
            IsDrug = false;
        }
    }
}
