import { Injectable } from '@angular/core';

const SESSION_KEY = 'sectors-form-session-id';

@Injectable({ providedIn: 'root' })
export class SessionService {

  getSessionId(): string {
    let id = sessionStorage.getItem(SESSION_KEY);
    if (!id) {
      id = crypto.randomUUID();
      sessionStorage.setItem(SESSION_KEY, id);
    }
    return id;
  }
}
