using Moq;
using PharmaGo.BusinessLogic;
using PharmaGo.DataAccess.Migrations;
using PharmaGo.DataAccess.Repositories;
using PharmaGo.Domain.Entities;
using PharmaGo.IBusinessLogic;
using PharmaGo.IDataAccess;
using System;
using System.Linq.Expressions;
using TechTalk.SpecFlow;

namespace SpecFlowProject.StepDefinitions
{
    [Binding]
    public class BuyProductStepDefinitions
    {
        private static Mock<IRepository<Purchase>> _purchasesRepository = new Mock<IRepository<Purchase>>();
        private static Mock<IRepository<Pharmacy>> _pharmacyRepository  = new Mock<IRepository<Pharmacy>>();
        private static Mock<IRepository<Drug>> _drugsRepository         = new Mock<IRepository<Drug>>();
        private static Mock<IRepository<Product>> _productRespository   = new Mock<IRepository<Product>>();
        private static Mock<IRepository<PurchaseDetail>> _purchaseDetailRepository = new Mock<IRepository<PurchaseDetail>>();
        private static Mock<IRepository<User>> _userRepository          = new Mock<IRepository<User>>();
        private static Mock<IRepository<Session>> _sessionRepository    = new Mock<IRepository<Session>>();

        private readonly IPurchasesManager _purchasesManager = new PurchasesManager(_purchasesRepository.Object,
                                                                                    _pharmacyRepository.Object,
                                                                                    _drugsRepository.Object,
                                                                                    _productRespository.Object,
                                                                                    _purchaseDetailRepository.Object,
                                                                                    _sessionRepository.Object,
                                                                                    _userRepository.Object);

        private readonly User user = new User() { Id = 1, UserName = "test", Email = "test@gmail.com", Address = "test" };

        private Pharmacy pharmacy1;
        private Product? Product1;
        private Purchase? Purchase1;

        private Pharmacy pharmacy2;
        private Product? Product2;
        private Purchase? Purchase2;

        private Pharmacy pharmacy3;
        private Product? Product3;
        private Product? Product3_2;
        private Purchase? Purchase3;

        private Pharmacy pharmacy4;
        private Pharmacy pharmacy4_2;
        private Product? Product4;
        private Product? Product4_2;
        private Purchase? Purchase4;

        private Pharmacy pharmacy5;
        private Pharmacy pharmacy5_2;
        private Product? Product5;
        private Drug? Product5_2;
        private Purchase? Purchase5;

        private Pharmacy pharmacy6;
        private Product? Product6;
        private Purchase? Purchase6;
        private Exception? Purchase6_exception;

        [Given(@"que en el escenario_I, selecciono un producto con una unidad")]
        public void GivenQueEnElEscenario_ISeleccionoUnProductoConUnaUnidad()
        {
            Pharmacy pharmacy1 = new Pharmacy() { Id = 1, Name = "pharmacy", Address = "address", Users = new List<User>(), Drugs = new List<Drug>(), Products = new List<Product>() };

            Product1 = new Product() { Id = 1, Code = 12345, Deleted = false, Description = "Prod1", Name = "Name1", Price = 100, Pharmacy = pharmacy1 };

            pharmacy1.Products.Add(Product1);

            this.pharmacy1 = pharmacy1;

            PurchaseDetail detail = new PurchaseDetail() { Id = 1, Product = Product1, Pharmacy = pharmacy1, Price = 100, Quantity = 1, Status = "Pending"};


            ICollection<PurchaseDetail> list = new List<PurchaseDetail>
            {
                detail
            };

            Purchase1 = new Purchase() {  Id = 1, BuyerEmail = user.Email, PurchaseDate = new DateTime(2015, 12, 31), TotalAmount = 100, details = list};
        }

        [When(@"en el escenario_I, presiono el botón de añadir al carrito y finalizo la compra")]
        public void WhenEnElEscenario_IPresionoElBotonDeAnadirAlCarritoYFinalizoLaCompra()
        {
            //El LambdaCompare es para que devuelva 'pharmacy1' sólo si lo busca por el ID correcto
            Expression<Func<Pharmacy, bool>> testExpression = binding => binding.Id == pharmacy1.Id;
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Pharmacy, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(pharmacy1);

            _purchasesRepository.Setup(x => x.InsertOne(It.IsAny<Purchase>()));
            _purchasesRepository.Setup(x => x.Save());

            _purchasesManager.CreatePurchase(Purchase1);
        }

        [Then(@"en el escenario_I, se compra el producto correctamente")]
        public void ThenEnElEscenario_ISeCompraElProductoCorrectamente()
        {
            //El LambdaCompare es para que devuelva 'Purchase1' sólo si lo busca por el TrackingCode correcto
            Expression<Func<Purchase, bool>> testExpression = binding => binding.TrackingCode == Purchase1.TrackingCode;
            _purchasesRepository.Setup(r => r.GetOneDetailByExpression(It.Is<Expression<Func<Purchase, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(Purchase1);

            Purchase pur1 = _purchasesManager.GetPurchaseByTrackingCode(Purchase1.TrackingCode);
            
            pur1.Should().NotBeNull();
            pur1.Should().BeEquivalentTo(Purchase1);
        }

        [Given(@"que en el escenario_II, selecciono un producto con dos unidades")]
        public void GivenQueEnElEscenario_IISeleccionoUnProductoConDosUnidades()
        {
            Pharmacy pharmacy2 = new Pharmacy() { Id = 2, Name = "pharmacy", Address = "address", Users = new List<User>(), Drugs = new List<Drug>(), Products = new List<Product>() };

            Product2 = new Product() { Id = 2, Code = 65321, Deleted = false, Description = "Prod2", Name = "Name2", Price = 100, Pharmacy = pharmacy2 };

            pharmacy2.Products.Add(Product2);

            this.pharmacy2 = pharmacy2;

            PurchaseDetail detail = new PurchaseDetail() { Id = 2, Product = Product2, Pharmacy = pharmacy2, Price = 200, Quantity = 2, Status = "Pending" };


            ICollection<PurchaseDetail> list = new List<PurchaseDetail>
            {
                detail
            };

            Purchase2 = new Purchase() { Id = 2, BuyerEmail = user.Email, PurchaseDate = new DateTime(2015, 12, 31), TotalAmount = 200, details = list };
        }

        [When(@"en el escenario_II, presiono el botón de añadir al carrito y finalizo la compra")]
        public void WhenEnElEscenario_IIPresionoElBotonDeAnadirAlCarritoYFinalizoLaCompra()
        {
            Expression<Func<Pharmacy, bool>> testExpression = binding => binding.Id == pharmacy2.Id;
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Pharmacy, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(pharmacy2);

            _purchasesRepository.Setup(x => x.InsertOne(It.IsAny<Purchase>()));
            _purchasesRepository.Setup(x => x.Save());

            _purchasesManager.CreatePurchase(Purchase2);
        }

        [Then(@"en el escenario_II, se compra las dos unidades del producto correctamente")]
        public void ThenEnElEscenario_IISeCompraLasDosUnidadesDelProductoCorrectamente()
        {
            Expression<Func<Purchase, bool>> testExpression = binding => binding.TrackingCode == Purchase2.TrackingCode;
            _purchasesRepository.Setup(r => r.GetOneDetailByExpression(It.Is<Expression<Func<Purchase, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(Purchase2);

            Purchase pur = _purchasesManager.GetPurchaseByTrackingCode(Purchase2.TrackingCode);

            pur.Should().NotBeNull();
            pur.Should().BeEquivalentTo(Purchase2);
        }

        [Given(@"que en el escenario_III, selecciono un producto con dos unidades, y otro producto de la misma farmacia con una unidad")]
        public void GivenQueEnElEscenario_IIISeleccionoUnProductoConDosUnidadesYOtroProductoDeLaMismaFarmaciaConUnaUnidad()
        {
            Pharmacy pharmacy3 = new Pharmacy() { Id = 3, Name = "pharmacy", Address = "address", Users = new List<User>(), Drugs = new List<Drug>(), Products = new List<Product>() };

            Product3 = new Product() { Id = 3, Code = 65331, Deleted = false, Description = "Prod3", Name = "Name3", Price = 100, Pharmacy = pharmacy3 };
            Product3_2 = new Product() { Id = 4, Code = 35331, Deleted = false, Description = "Prod3_2", Name = "Name3_2", Price = 75, Pharmacy = pharmacy3 };

            pharmacy3.Products.Add(Product3);
            pharmacy3.Products.Add(Product3_2);

            this.pharmacy3 = pharmacy3;

            PurchaseDetail detail = new PurchaseDetail() { Id = 3, Product = Product3, Pharmacy = pharmacy3, Price = 200, Quantity = 2, Status = "Pending" };
            PurchaseDetail detail2 = new PurchaseDetail() { Id = 4, Product = Product3_2, Pharmacy = pharmacy3, Price = 75, Quantity = 1, Status = "Pending" };

            ICollection<PurchaseDetail> list = new List<PurchaseDetail>
            {
                detail,
                detail2
            };

            Purchase3 = new Purchase() { Id = 3, BuyerEmail = user.Email, PurchaseDate = new DateTime(2015, 12, 21), TotalAmount = 275, details = list };
        }

        [When(@"en el escenario_III, presiono el botón de añadir al carrito y finalizo la compra")]
        public void WhenEnElEscenario_IIIPresionoElBotonDeAnadirAlCarritoYFinalizoLaCompra()
        {
            Expression<Func<Pharmacy, bool>> testExpression = binding => binding.Id == pharmacy3.Id;
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Pharmacy, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(pharmacy3);

            _purchasesRepository.Setup(x => x.InsertOne(It.IsAny<Purchase>()));
            _purchasesRepository.Setup(x => x.Save());

            _purchasesManager.CreatePurchase(Purchase3);
        }

        [Then(@"en el escenario_III, se compra las tres unidades de los productos correctamente")]
        public void ThenEnElEscenario_IIISeCompraLasTresUnidadesDeLosProductosCorrectamente()
        {
            Expression<Func<Purchase, bool>> testExpression = binding => binding.TrackingCode == Purchase3.TrackingCode;
            _purchasesRepository.Setup(r => r.GetOneDetailByExpression(It.Is<Expression<Func<Purchase, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(Purchase3);

            Purchase pur = _purchasesManager.GetPurchaseByTrackingCode(Purchase3.TrackingCode);

            pur.Should().NotBeNull();
            pur.Should().BeEquivalentTo(Purchase3);
        }

        [Given(@"que en el escenario_IV, selecciono un producto con dos unidades, y otro producto de distinta farmacia con una unidad")]
        public void GivenQueEnElEscenario_IVSeleccionoUnProductoConDosUnidadesYOtroProductoDeDistintaFarmaciaConUnaUnidad()
        {
            Pharmacy pharmacy4 = new Pharmacy() { Id = 4, Name = "pharmacy", Address = "address", Users = new List<User>(), Drugs = new List<Drug>(), Products = new List<Product>() };
            Pharmacy pharmacy4_2 = new Pharmacy() { Id = 5, Name = "pharmacy42", Address = "address42", Users = new List<User>(), Drugs = new List<Drug>(), Products = new List<Product>() };

            Product4 = new Product() { Id = 3, Code = 65331, Deleted = false, Description = "Prod4", Name = "Name4", Price = 100, Pharmacy = pharmacy4 };
            Product4_2 = new Product() { Id = 4, Code = 35331, Deleted = false, Description = "Prod4_2", Name = "Name4_2", Price = 75, Pharmacy = pharmacy4_2 };

            pharmacy4.Products.Add(Product4);
            pharmacy4_2.Products.Add(Product4_2);

            this.pharmacy4 = pharmacy4;
            this.pharmacy4_2 = pharmacy4_2;

            PurchaseDetail detail = new PurchaseDetail() { Id = 3, Product = Product4, Pharmacy = pharmacy4, Price = 200, Quantity = 2, Status = "Pending" };
            PurchaseDetail detail2 = new PurchaseDetail() { Id = 4, Product = Product4_2, Pharmacy = pharmacy4_2, Price = 75, Quantity = 1, Status = "Pending" };

            ICollection<PurchaseDetail> list = new List<PurchaseDetail>
            {
                detail,
                detail2
            };

            Purchase4 = new Purchase() { Id = 4, BuyerEmail = user.Email, PurchaseDate = new DateTime(2015, 12, 21), TotalAmount = 275, details = list };
        }

        [When(@"en el escenario_IV, presiono el botón de añadir al carrito y finalizo la compra")]
        public void WhenEnElEscenario_IVPresionoElBotonDeAnadirAlCarritoYFinalizoLaCompra()
        {
            Expression<Func<Pharmacy, bool>> testExpression = binding => binding.Id == pharmacy4.Id;
            Expression<Func<Pharmacy, bool>> testExpression2 = binding => binding.Id == pharmacy4_2.Id;
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Pharmacy, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(pharmacy4);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Pharmacy, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression2)))).Returns(pharmacy4_2);

            _purchasesRepository.Setup(x => x.InsertOne(It.IsAny<Purchase>()));
            _purchasesRepository.Setup(x => x.Save());

            _purchasesManager.CreatePurchase(Purchase4);
        }

        [Then(@"en el escenario_IV, se compra las tres unidades de los productos correctamente")]
        public void ThenEnElEscenario_IVSeCompraLasTresUnidadesDeLosProductosCorrectamente()
        {
            Expression<Func<Purchase, bool>> testExpression = binding => binding.TrackingCode == Purchase4.TrackingCode;
            _purchasesRepository.Setup(r => r.GetOneDetailByExpression(It.Is<Expression<Func<Purchase, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(Purchase4);

            Purchase pur = _purchasesManager.GetPurchaseByTrackingCode(Purchase4.TrackingCode);

            pur.Should().NotBeNull();
            pur.Should().BeEquivalentTo(Purchase4);
        }

        [Given(@"que en el escenario_V, selecciono un producto y un medicamento")]
        public void GivenQueEnElEscenario_VSeleccionoUnProductoYUnMedicamento()
        {
            Pharmacy pharmacy5 = new Pharmacy() { Id = 5, Name = "pharmacy", Address = "address", Users = new List<User>(), Drugs = new List<Drug>(), Products = new List<Product>() };
            Pharmacy pharmacy5_2 = new Pharmacy() { Id = 6, Name = "pharmacy62", Address = "address62", Users = new List<User>(), Drugs = new List<Drug>(), Products = new List<Product>() };

            Product5 = new Product() { Id = 5, Code = 65331, Deleted = false, Description = "Prod6", Name = "Name4", Price = 100, Pharmacy = pharmacy5 };
            Product5_2 = new Drug() { Id = 6, Code = "35331", Deleted = false, Name = "Name4_2", Price = 75, Pharmacy = pharmacy5_2 };

            pharmacy5.Products.Add(Product5);
            pharmacy5_2.Drugs.Add(Product5_2);

            this.pharmacy5 = pharmacy5;
            this.pharmacy5_2 = pharmacy5_2;

            PurchaseDetail detail = new PurchaseDetail() { Id = 3, Product = Product5, Pharmacy = pharmacy5, Price = 200, Quantity = 2, Status = "Pending" };
            PurchaseDetail detail2 = new PurchaseDetail() { Id = 4, Drug = Product5_2, Pharmacy = pharmacy5_2, Price = 75, Quantity = 1, Status = "Pending" };

            ICollection<PurchaseDetail> list = new List<PurchaseDetail>
            {
                detail,
                detail2
            };

            Purchase5 = new Purchase() { Id = 5, BuyerEmail = user.Email, PurchaseDate = new DateTime(2015, 12, 21), TotalAmount = 275, details = list };
        }

        [When(@"en el escenario_V, presiono el botón de añadir al carrito y finalizo la compra")]
        public void WhenEnElEscenario_VPresionoElBotonDeAnadirAlCarritoYFinalizoLaCompra()
        {
            Expression<Func<Pharmacy, bool>> testExpression = binding => binding.Id == pharmacy5.Id;
            Expression<Func<Pharmacy, bool>> testExpression2 = binding => binding.Id == pharmacy5_2.Id;
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Pharmacy, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(pharmacy5);
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Pharmacy, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression2)))).Returns(pharmacy5_2);

            _purchasesRepository.Setup(x => x.InsertOne(It.IsAny<Purchase>()));
            _purchasesRepository.Setup(x => x.Save());

            _purchasesManager.CreatePurchase(Purchase5);
        }

        [Then(@"en el escenario_V, se compra del producto y medicamentos se realiza correctamente\.")]
        public void ThenEnElEscenario_VSeCompraDelProductoYMedicamentosSeRealizaCorrectamente_()
        {
            Expression<Func<Purchase, bool>> testExpression = binding => binding.TrackingCode == Purchase5.TrackingCode;
            _purchasesRepository.Setup(r => r.GetOneDetailByExpression(It.Is<Expression<Func<Purchase, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(Purchase5);

            Purchase pur = _purchasesManager.GetPurchaseByTrackingCode(Purchase5.TrackingCode);

            pur.Should().NotBeNull();
            pur.Should().BeEquivalentTo(Purchase5);
        }

        [Given(@"que en el escenario_VI, selecciono un producto con cantidad negativa")]
        public void GivenQueEnElEscenario_VISeleccionoUnProductoConCantidadNegativa()
        {
            Pharmacy pharmacy6 = new Pharmacy() { Id = 1, Name = "pharmacy", Address = "address", Users = new List<User>(), Drugs = new List<Drug>(), Products = new List<Product>() };

            Product6 = new Product() { Id = 6, Code = 12345, Deleted = false, Description = "Prod1", Name = "Name1", Price = 100, Pharmacy = pharmacy1 };

            pharmacy6.Products.Add(Product1);

            this.pharmacy6 = pharmacy6;

            PurchaseDetail detail = new PurchaseDetail() { Id = 6, Product = Product6, Pharmacy = pharmacy6, Price = 100, Quantity = -1, Status = "Pending" };


            ICollection<PurchaseDetail> list = new List<PurchaseDetail>
            {
                detail
            };

            Purchase6 = new Purchase() { Id = 6, BuyerEmail = user.Email, PurchaseDate = new DateTime(2015, 12, 31), TotalAmount = 100, details = list };
        }

        [When(@"en el escenario_VI, presiono el botón de añadir al carrito e intento finalizar la compra")]
        public void WhenEnElEscenario_VIPresionoElBotonDeAnadirAlCarritoEIntentoFinalizarLaCompra()
        {
            Expression<Func<Pharmacy, bool>> testExpression = binding => binding.Id == pharmacy6.Id;
            _pharmacyRepository.Setup(r => r.GetOneByExpression(It.Is<Expression<Func<Pharmacy, bool>>>(criteria => Neleus.LambdaCompare.Lambda.Eq(criteria, testExpression)))).Returns(pharmacy6);

            _purchasesRepository.Setup(x => x.InsertOne(It.IsAny<Purchase>()));
            _purchasesRepository.Setup(x => x.Save());

            try
            {
                _purchasesManager.CreatePurchase(Purchase6);
            }
            catch (Exception e)
            {
                Purchase6_exception = e;
            }
        }

        [Then(@"en el escenario_VI, no se compra del producto por monto negativo\.")]
        public void ThenEnElEscenario_VINoSeCompraDelProductoPorMontoNegativo_()
        {
            Purchase6_exception.Should().NotBeNull();
        }
    }
}
