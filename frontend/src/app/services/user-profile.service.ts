import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserProfileRequest, UserProfileResponse } from '../models/user-profile.model';

@Injectable({ providedIn: 'root' })
export class UserProfileService {
  private readonly apiUrl = 'http://localhost:8080/api/user-profile';

  constructor(private http: HttpClient) {}

  saveProfile(request: UserProfileRequest): Observable<UserProfileResponse> {
    return this.http.post<UserProfileResponse>(this.apiUrl, request);
  }

  getProfile(sessionId: string): Observable<UserProfileResponse> {
    return this.http.get<UserProfileResponse>(`${this.apiUrl}/${sessionId}`);
  }
}
