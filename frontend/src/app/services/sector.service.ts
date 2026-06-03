import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Sector } from '../models/sector.model';
import { environment } from '../../environments/environment';

@Injectable({ providedIn: 'root' })
export class SectorService {
  private readonly apiUrl = `${environment.apiUrl}/sectors`;

  constructor(private http: HttpClient) {}

  getAll(): Observable<Sector[]> {
    return this.http.get<Sector[]>(this.apiUrl);
  }
}
