import { inject, Injectable } from '@angular/core';
import { ApiService } from './api.service';
import { stint } from '../interfaces/stint';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StintService {

  private _api = inject(ApiService);

    getStints(attributes?: Partial<stint>) : Observable<stint[]> {
      return this._api.apiGet<stint>('/stints', attributes);
    }

  constructor() { }
}
