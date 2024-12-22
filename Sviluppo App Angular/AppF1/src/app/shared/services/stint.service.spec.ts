import { TestBed } from '@angular/core/testing';

import { StintService } from './stint.service';

describe('StintService', () => {
  let service: StintService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(StintService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
