import { SessionService } from './session.service';

describe('SessionService', () => {
  let service: SessionService;

  beforeEach(() => {
    sessionStorage.clear();
    service = new SessionService();
  });

  it('generates a new session ID when none exists', () => {
    const id = service.getSessionId();
    expect(id).toBeTruthy();
    expect(id.length).toBeGreaterThan(0);
  });

  it('returns the same session ID on subsequent calls', () => {
    const first  = service.getSessionId();
    const second = service.getSessionId();
    expect(first).toBe(second);
  });

  it('persists session ID in sessionStorage', () => {
    const id = service.getSessionId();
    expect(sessionStorage.getItem('sectors-form-session-id')).toBe(id);
  });

  it('reuses existing session ID from sessionStorage', () => {
    sessionStorage.setItem('sectors-form-session-id', 'existing-id');
    const id = service.getSessionId();
    expect(id).toBe('existing-id');
  });
});
