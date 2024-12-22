import { inject, Injectable } from '@angular/core';
import { driver } from '../interfaces/driver';
import { map, Observable } from 'rxjs';
import { ApiService } from './api.service';

@Injectable({
  providedIn: 'root'
})
export class DriverService {


  private _api = inject(ApiService);

  getDrivers(attributes?: Partial<driver>) : Observable<driver[]> {
    return this._api.apiGet<driver>('/drivers', attributes);
  }


  constructor() { }
}


