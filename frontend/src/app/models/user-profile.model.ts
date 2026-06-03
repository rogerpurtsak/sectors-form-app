export interface UserProfileRequest {
  sessionId: string;
  name: string;
  sectorIds: number[];
  agreeToTerms: boolean;
}

export interface UserProfileResponse {
  sessionId: string;
  name: string;
  sectorIds: number[];
  agreeToTerms: boolean;
}
