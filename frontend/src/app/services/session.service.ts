import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class SessionService {
  private savedProfileId: number | null = null;

  getSavedProfileId(): number | null {
    return this.savedProfileId;
  }

  setSavedProfileId(id: number): void {
    this.savedProfileId = id;
  }

  hasSavedProfile(): boolean {
    return this.savedProfileId !== null;
  }

  clear(): void {
    this.savedProfileId = null;
  }
}
