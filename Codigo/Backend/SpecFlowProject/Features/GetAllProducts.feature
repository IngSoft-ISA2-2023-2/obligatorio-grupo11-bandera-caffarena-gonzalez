Feature: getAllProducts

@mytag
Scenario: Correcta obtencion de los productos
	Given Una famacia de id 12345
	And existe un producto en la base
	When cargo la lista de productos
	Then se cargan los productos correctamente

@mytag
Scenario: Incorrecta obtencion de los productos de una farmacia
	Given un id de farmacia 12345789 que no existe
	When quiero ver los prdocutos de la farmacia
	Then no se cargan los productos y salta un error

