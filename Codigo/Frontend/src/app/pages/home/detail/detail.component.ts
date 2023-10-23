import { Component, OnInit} from '@angular/core';
import { cilCart, cilPlus, cilCompass } from '@coreui/icons';
import { IconSetService } from '@coreui/icons-angular';
import { ActivatedRoute } from '@angular/router';
import { Drug } from 'src/app/interfaces/drug';
import { DrugService } from '../../../services/drug.service';
import { StorageManager } from '../../../utils/storage-manager';
import { Router } from '@angular/router'; 
import { CommonService } from '../../../services/CommonService';
import { Product } from 'src/app/interfaces/product';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-detail',
  templateUrl: './detail.component.html',
  styleUrls: ['./detail.component.css'],
})
export class DetailComponent implements OnInit {
  purchaseItem: any | undefined;
  quantity: number = 1;
  cart: any[] = [];
  type: string = "";

  constructor(
    private route: ActivatedRoute,
    public iconSet: IconSetService,
    private drugService: DrugService,
    private productService: ProductService,
    private storageManager: StorageManager,
    private router: Router,
    private commonService: CommonService
  ) {
    iconSet.icons = { cilCart, cilPlus, cilCompass };
  }

  ngOnInit(): void {
    this.type = this.route.snapshot.paramMap.get('type')!;
    console.log(this.type);
    this.type === 'drug' ? this.getDrug() : this.getProduct();
    this.storageManager.saveData('total', JSON.stringify(0));
  }

  getDrug(): void {
    const id = parseInt(this.route.snapshot.paramMap.get('id')!, 10);
    this.drugService.getDrug(id).subscribe((drug) => (this.purchaseItem = drug));
  }

  getProduct(): void {
    const id = parseInt(this.route.snapshot.paramMap.get('id')!, 10);
    this.productService.getProduct(id).subscribe((product) => (this.purchaseItem = product));
  }

  addToCart(purchaseItem: any) {
    if (purchaseItem) {
      this.cart = JSON.parse(this.storageManager.getData('cart'));
      if (!this.cart) {
        this.cart = [];
        this.storageManager.saveData('cart', JSON.stringify(this.cart));
      }
      
      let exist: boolean = false;
      for (let item of this.cart) {
        if (item.code === purchaseItem.code && item.id === purchaseItem.id){
          item.quantity += this.quantity;
          exist = true;
          break;
        }
      }
      if (!exist){
        purchaseItem.quantity = this.quantity;
        this.type === 'drug' ? purchaseItem.isDrug = true : purchaseItem.isDrug = false;
        this.cart.push(purchaseItem);
      }
      this.storageManager.saveData('cart', JSON.stringify(this.cart));
    }
    this.updateHeader(this.cart.length);
    this.router.navigate(['/home/cart']);
  }

  updateHeader(value: number){
    this.commonService.updateHeaderData(value);
   }

}
