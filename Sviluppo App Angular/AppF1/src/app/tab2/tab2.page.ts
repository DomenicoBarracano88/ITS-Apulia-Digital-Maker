import { Component, inject } from '@angular/core';
import { IonHeader, IonToolbar, IonTitle, IonContent, IonList, IonSkeletonText, IonLabel, IonButton, IonItem, IonCard, IonCardHeader, IonCardTitle, IonCardSubtitle, IonCardContent, IonSelect, IonSelectOption, IonText } from '@ionic/angular/standalone';import { ExploreContainerComponent } from '../explore-container/explore-container.component';
import { GrandPrixService } from '../shared/services/grand-prix.service';
import { grandPrix } from '../shared/interfaces/grandPrix';
import { Router, RouterModule } from '@angular/router';
import { catchError, of } from 'rxjs';
import { AlertController } from '@ionic/angular';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss'],
  standalone: true,
  imports: [IonText, IonCardContent, IonCardSubtitle, FormsModule, IonCardTitle, IonCardHeader, CommonModule, IonCard, IonItem, IonButton, IonLabel, IonSkeletonText, IonList, IonHeader, IonToolbar, IonTitle, IonContent, ExploreContainerComponent, RouterModule, IonSelect,IonSelectOption]
})
export class Tab2Page {

  isLoading = false;
  isError = false;

  years: number[] = [];
  selectedYear: number | null = null;

  private _api = inject(GrandPrixService);
  private _alertCtrl = inject(AlertController);
  private _router = inject(Router);
  grandPrix: grandPrix[] = [];



  constructor() { 
    this._api.getGrandPrix().pipe(
  catchError((err) => {
    this.isError = true;
    this.presentAlert(err.message);
    this.isLoading = false;
    return of([]); 
  })
).subscribe((data) => {

  this.isLoading = false;
  console.log('Dati ricevuti:', data); // Debugging

  this.grandPrix = data;

  this.years = Array.from(new Set(data.map(gp => gp.year))).sort((a, b) => b - a);
  console.log('Anni disponibili:', this.years); // Debugging
});
   }


   OnRefreshPage() {
    location.reload();
   }
   async presentAlert(message: string) {
    const alert = await this._alertCtrl.create({
      header: 'OPS',
      message: `Si è verificato un errore: ${message}`,
      buttons: ['OK'],
    });

    await alert.present();
  }

  getFilteredGrandPrix() {
    if (this.selectedYear) {
      return this.grandPrix.filter(gp => gp.year === this.selectedYear);
    }
    return this.grandPrix;
  }

}
