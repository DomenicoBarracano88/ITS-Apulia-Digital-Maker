import { inject, Injectable } from '@angular/core';
import { ApiService } from './api.service';
import { grandPrix } from '../interfaces/grandPrix';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class GrandPrixService {


  private _api = inject(ApiService);

  getGrandPrix(attributes?: Partial<grandPrix>) : Observable<grandPrix[]> {
    return this._api.apiGet<grandPrix>('/meetings', attributes);
  }
  
  constructor() { }
}
