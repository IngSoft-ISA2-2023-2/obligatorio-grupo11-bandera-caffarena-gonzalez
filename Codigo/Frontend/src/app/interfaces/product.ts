export interface Product {
    id: number;
    code: number;
    name: string;
    description: string;
    price: number;
    pharmacy: {
      id: number;
      name: string;  
    };
  }

  export class ProductRequest {
    code: number;
    name: string;
    description: string;
    price: number;
    pharmacyName: string = "";

    constructor(code: number, name: string, description: string, price: number, pharmacyName: string){
      this.code = code;
      this.name = name;
      this.description = description;
      this.price = price;
      this.pharmacyName = pharmacyName;
    }
  }