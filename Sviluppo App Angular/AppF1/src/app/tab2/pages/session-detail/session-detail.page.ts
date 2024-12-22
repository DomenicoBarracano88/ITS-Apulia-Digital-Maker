import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { IonContent, IonHeader, IonTitle, IonToolbar, IonItem, IonCard, IonCardHeader, IonCardTitle, IonCardSubtitle, IonCardContent, IonSelect, IonSelectOption, IonLabel, IonSegment, IonSegmentButton, IonBackButton, IonButtons, IonButton, IonIcon, IonImg } from '@ionic/angular/standalone';
import { SessionService } from 'src/app/shared/services/session.service';
import { session } from 'src/app/shared/interfaces/session';
import { ActivatedRoute } from '@angular/router';
import { ChartModule } from 'primeng/chart';
import { PositionService } from 'src/app/shared/services/position.service';
import { DriverService } from 'src/app/shared/services/driver.service';
import { driver } from 'src/app/shared/interfaces/driver';
import { weather } from 'src/app/shared/interfaces/weather';
import { WeatherService } from 'src/app/shared/services/weather.service';
import { StintService } from 'src/app/shared/services/stint.service';

export type SegmentSessionDetail = 'session' | 'weather' | 'drivers';

@Component({
  selector: 'app-session-detail',
  templateUrl: './session-detail.page.html',
  styleUrls: ['./session-detail.page.scss'],
  standalone: true,
  imports: [IonImg, IonIcon, IonButton, IonButtons, IonBackButton, IonSegmentButton, IonSegment, IonSelect, IonSelectOption, IonLabel, ChartModule, FormsModule, IonCardContent, IonCardSubtitle, IonCardTitle, IonCardHeader, IonCard, IonItem, IonContent, IonHeader, IonTitle, IonToolbar, CommonModule, ReactiveFormsModule]
})

export class SessionDetailPage {

  segmentValue: 'session' | 'weather' | 'drivers' = 'session';
  private _apiSession = inject(SessionService);
  private _apiPosition = inject(PositionService);
  private _apiStint = inject(StintService)
  private _apiDriver = inject(DriverService);
  private _apiWeather = inject(WeatherService);
  private _activatedRoute = inject(ActivatedRoute);
  sessionKey: number;
  weather: weather[] = [];
  sessions: session[] = [];
  drivers: driver[] = [];
  selectedDrivers: number[] = [];
  data: any;
  options = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
    },
    scales: {
      x: {
        title: {
          display: true,
          text: 'Tempo',
        },
      },
      y: {
        title: {
          display: true,
          text: 'Posizione',
        },
      },
    },
  };

  constructor() {
    this.sessionKey = this._activatedRoute.snapshot.params['idSession'];
    this._apiSession.getSessions({ session_key: this.sessionKey }).subscribe((data) => {
      this.sessions = data;
    });
    this._apiDriver.getDrivers({ session_key: this.sessionKey }).subscribe((data) => {
      this.drivers = data;
    });
    this._apiWeather.getWeather({ session_key: this.sessionKey }).subscribe((data) => {
      this.weather = data;
    });
  }

  onDriversChange(event: any) {
    this.selectedDrivers = event.detail.value;
    this.loadDriversPosition();
  }

  loadDriversPosition() {
    if (this.selectedDrivers.length === 0) {
      this.data = null;
      return;
    }

    const datasets: { label: string, data: number[], fill: boolean, borderColor: string, tension: number }[] = [];

    this.selectedDrivers.forEach((driverNumber) => {
      this._apiPosition.getDriverPosition({ session_key: this.sessionKey, driver_number: driverNumber }).subscribe((positions) => {

        // Trova il driver corrente per ottenere il team_colour
        const driver = this.drivers.find(d => d.driver_number === driverNumber);

        if (driver) {
          // Prepara le etichette (laps)
          const labels = positions.map((pos, index) => `Lap ${index + 1}`);
          const dataSet = positions.map(pos => pos.position);

          // Controlla se il team_colour inizia con #, altrimenti aggiungilo
          const teamColor = driver.team_colour.startsWith('#') ? driver.team_colour : `#${driver.team_colour}`;
          
          // Aggiungi il dataset per il pilota
          datasets.push({
            label: driver.full_name,
            data: dataSet,
            fill: false,
            borderColor: teamColor,  // Usa il colore del team
            tension: 0.4
          });

          // Quando tutti i dataset sono stati creati, aggiorna i dati del grafico
          if (datasets.length === this.selectedDrivers.length) {
            this.data = {
              labels: labels,  // Visualizza i giri come "Lap 1", "Lap 2", ecc.
              datasets: datasets
            };
          }
        }
      });
    });
  }


  getAverageAirTemperature(): number {
    if (this.weather.length === 0) {
      return 0;
    }
    const totalTemperature = this.weather.reduce((acc, weatherEntry) => acc + weatherEntry.air_temperature, 0);
    return totalTemperature / this.weather.length;
  }
  
  getAverageTrackTemperature(): number {
    if (this.weather.length === 0) {
      return 0;
    }
    const totalTemperature = this.weather.reduce((acc, weatherEntry) => acc + weatherEntry.track_temperature, 0);
    return totalTemperature / this.weather.length;
  }

  onSegmentChange(event: any) {
    this.segmentValue = event.detail.value as SegmentSessionDetail;
   }

}