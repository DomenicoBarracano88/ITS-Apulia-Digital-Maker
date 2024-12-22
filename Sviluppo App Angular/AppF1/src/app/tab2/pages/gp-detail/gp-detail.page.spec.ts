import { ComponentFixture, TestBed } from '@angular/core/testing';
import { GpDetailPage } from './gp-detail.page';

describe('GpDetailPage', () => {
  let component: GpDetailPage;
  let fixture: ComponentFixture<GpDetailPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(GpDetailPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
