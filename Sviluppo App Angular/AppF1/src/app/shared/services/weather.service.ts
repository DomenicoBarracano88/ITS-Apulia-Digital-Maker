import { inject, Injectable } from '@angular/core';
import { ApiService } from './api.service';
import { weather } from '../interfaces/weather';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class WeatherService {

  private _api = inject(ApiService);
  
  getWeather(attributes?: Partial<weather>) : Observable<weather[]> {
    return this._api.apiGet<weather>('/weather', attributes);
  }

  constructor() { }
}
