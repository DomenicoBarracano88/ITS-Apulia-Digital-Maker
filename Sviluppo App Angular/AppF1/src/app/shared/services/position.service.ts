import { inject, Injectable } from '@angular/core';
import { ApiService } from './api.service';
import { position } from '../interfaces/position';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PositionService {

  private _api = inject(ApiService);

  getDriverPosition(attributes?: Partial<position>) : Observable<position[]> {
    return this._api.apiGet<position>('/position', attributes);
  }

  constructor() { }
}
