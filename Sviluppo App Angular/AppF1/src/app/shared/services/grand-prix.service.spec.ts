import { TestBed } from '@angular/core/testing';

import { GrandPrixService } from './grand-prix.service';

describe('GrandPrixService', () => {
  let service: GrandPrixService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(GrandPrixService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
