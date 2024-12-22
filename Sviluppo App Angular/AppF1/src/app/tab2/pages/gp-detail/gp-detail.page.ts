import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonContent, IonHeader, IonTitle, IonToolbar, IonSegment, IonImg, IonItem, IonLabel, IonSegmentButton, IonButton, IonButtons, IonBackButton } from '@ionic/angular/standalone';
import { session } from 'src/app/shared/interfaces/session';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { SessionService } from 'src/app/shared/services/session.service';


@Component({
  selector: 'app-gp-detail',
  templateUrl: './gp-detail.page.html',
  styleUrls: ['./gp-detail.page.scss'],
  standalone: true,
  imports: [IonBackButton, IonButtons, IonButton, IonSegmentButton, IonLabel, IonItem, IonImg, IonSegment, IonContent, IonHeader, IonTitle, IonToolbar, CommonModule, FormsModule, RouterModule]
})


export class GpDetailPage implements OnInit {


  meetingKey: number;
  sessions: session[] = [];
  private _apiSession = inject(SessionService);
  private _router = inject(Router);
  private _activatedRoute = inject(ActivatedRoute);


  constructor() {
      this.meetingKey = this._activatedRoute.snapshot.params['idMeeting'];
      this._apiSession.getSessions({meeting_key : this.meetingKey}).subscribe((data) => {
        this.sessions = data;
      });
  }

   openDetailPage(sessionKey: string) {
    this._router.navigate([`/tabs/tab2/${sessionKey}`]);
  }

  ngOnInit() {
  }

}
