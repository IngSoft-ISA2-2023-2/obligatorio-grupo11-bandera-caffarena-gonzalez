import { Component, OnInit } from '@angular/core';
import { cilCheckAlt, cilX } from '@coreui/icons';
import { Product } from 'src/app/interfaces/product';
import { CommonService } from 'src/app/services/CommonService';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-delete-product',
  templateUrl: './delete-product.component.html',
  styleUrls: ['./delete-product.component.css']
})
export class DeleteProductComponent implements OnInit {
  products: Product[] = [];
  icons = { cilCheckAlt, cilX };
  targetItem: any = undefined;
  visible = false;
  modalTitle = '';
  modalMessage = '';
  
  constructor(
    private commonService: CommonService,
    private productService: ProductService
  ) { }

  ngOnInit(): void {
    //this.getProductsByUser();
    //Pre charge products for testing
    this.products = [
      {id: 1,
       code: 12345,
       name: "Shampoo",
       description: "Dale vida a tu pelo",
       price: 200,
       pharmacy: {
        id: 1,
        name: "La Pigalle"
       }
      },
      {id: 2,
        code: 47645,
        name: "Pasta dental",
        description: "Manten un buen aliento",
        price: 200,
        pharmacy: {
         id: 1,
         name: "La Pigalle"
        }
      }
    ]
  }

  getProductsByUser() {
    this.productService.getProducts().subscribe((prod: any) => (this.products = prod));
  }

  deleteProduct(index: number): void {
    for (let product of this.products) {
      if (product.id === index) {
        this.targetItem = product;
        break;
      }
    }
    if (this.targetItem) {
      this.modalTitle = 'Delete Product';
      this.modalMessage = `Deleting '${this.targetItem.code} - ${this.targetItem.name}'. Are you sure ?`;
      this.visible = true;
    }
  }

  closeModal(): void {
    this.visible = false;
  }

  saveModal(event: any): void {
    if (event) {
      this.productService.deleteProduct(this.targetItem.id).subscribe((p: any) => {
        if (p) {
          this.visible = false;
          this.getProductsByUser();
          this.commonService.updateToastData(
            `Success deleting product "${this.targetItem.code} - ${this.targetItem.name}"`,
            'success',
            'Product deleted.'
          );
        }
      });
    }
  }

}
