import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./tabs/tabs.routes').then((m) => m.routes),
  },
  {
    path: 'gp-detail',
    loadComponent: () => import('./tab2/pages/gp-detail/gp-detail.page').then( m => m.GpDetailPage)
  },
  {
    path: 'session-detail',
    loadComponent: () => import('./tab2/pages/session-detail/session-detail.page').then( m => m.SessionDetailPage)
  },
];
