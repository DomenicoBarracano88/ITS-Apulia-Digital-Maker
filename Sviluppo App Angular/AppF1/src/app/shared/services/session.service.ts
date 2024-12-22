import { inject, Injectable } from '@angular/core';
import { session } from '../interfaces/session';
import { Observable } from 'rxjs';
import { ApiService } from './api.service';

@Injectable({
  providedIn: 'root'
})
export class SessionService {


  private _api = inject(ApiService);

  getSessions(attributes?: Partial<session>) : Observable<session[]> {
    return this._api.apiGet<session>('/sessions', attributes);
  }


  constructor() { }
}
