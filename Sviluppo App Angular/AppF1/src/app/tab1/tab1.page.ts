import { Component, inject } from '@angular/core';
import { IonHeader, IonToolbar, IonTitle, IonContent, IonCard, IonList, IonSkeletonText, IonCardHeader, IonCardTitle, IonCardSubtitle, IonLabel, IonButton, IonCardContent } from '@ionic/angular/standalone';
import { ExploreContainerComponent } from '../explore-container/explore-container.component';
import { DriverService } from '../shared/services/driver.service';
import { driver } from '../shared/interfaces/driver';
import { catchError, of } from 'rxjs';
import { AlertController } from '@ionic/angular';

@Component({
  selector: 'app-tab1',
  templateUrl: 'tab1.page.html',
  styleUrls: ['tab1.page.scss'],
  standalone: true,
  imports: [IonCardContent, IonButton, IonLabel, IonCardSubtitle, IonCardTitle, IonCardHeader, IonSkeletonText, IonList, IonCard, IonHeader, IonToolbar, IonTitle, IonContent, ExploreContainerComponent],
})

export class Tab1Page {

  isLoading = false;
  isError = false;

  private _api = inject(DriverService);
  private _alertCtrl = inject(AlertController);

  drivers: driver[] = [];

  constructor() {
    this._api.getDrivers().pipe(catchError((err) => {
      this.isError = true;
      this.presentAlert(err.message)
      this.isLoading = false;
      return of([]);
    }))
    .subscribe((data) => {
      this.isLoading = true;

      const singleDrivers = Array.from(new Map(data.map(driver => [driver.driver_number, driver])).values());
      this.drivers = singleDrivers;
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
}

