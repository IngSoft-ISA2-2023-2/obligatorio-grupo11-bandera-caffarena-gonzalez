Feature: getProductByUser

@mytag
Scenario: Correcta obtencion de los productos por farmacia
	Given un usuario
	When hago la peticion para ver los productos de su farmacia
	Then obtengo los productos


